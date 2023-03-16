//
//  Offering+CollectionView.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 3/8/23.
//

import Foundation
import UIKit
import StoreKit

extension Offering {

    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { (sectionIndex, _) -> NSCollectionLayoutSection? in
            let currentSection = Offering.Sections[sectionIndex]
            // MARK: IMPORTANT - IN ORDER FOR THIS ESTIMATED LAYOUT TO WORK THE ESTIMATED HEIGHT MUST BE 0. ITS STILL BUGGY AND THIS WILL CREATE ERROR LOGS BUT IT WILL WORK
            let itemWidth: NSCollectionLayoutDimension = .fractionalWidth(1)
            let itemHeight: NSCollectionLayoutDimension
            let contentInsetConstant: CGFloat
            switch Offering.Sections[sectionIndex] {
            case .consumablesTitle, .nonConsumablesTitle, .nonRenewingSubscriptionsTitle, .autoRenewableSubscriptionsTitle:
                itemHeight = .estimated(120)
                contentInsetConstant = 0
                break
            case .consumables, .nonConsumables, .nonRenewingSubscriptions, .autoRenewableSubscriptionsIndividualPlans, .autoRenewableSubscriptionsFamilyPlans:
                itemHeight = .estimated(250)
                contentInsetConstant = kPadding
                break
            case .offerCodesAndRefunds:
                itemHeight = .absolute(3 * kPadding + 2 * kButtonDimension)
                contentInsetConstant = 0
                break
            case .restorePurchasesTitle:
                itemHeight = .estimated(120)
                contentInsetConstant = 0
                break
            case .restorePurchases:
                itemHeight = .absolute(kButtonDimension)
                contentInsetConstant = 0
                break
            }

            // Item
            let itemSize = NSCollectionLayoutSize(widthDimension: itemWidth, heightDimension: itemHeight)
            let item = NSCollectionLayoutItem(layoutSize: itemSize)

            // Group
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: itemHeight)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            group.interItemSpacing = .fixed(kPadding)
            // Section
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = kPadding

            section.contentInsets = NSDirectionalEdgeInsets(top: contentInsetConstant, leading: contentInsetConstant, bottom: contentInsetConstant, trailing: contentInsetConstant)

            if currentSection == .autoRenewableSubscriptionsIndividualPlans
                || currentSection == .autoRenewableSubscriptionsFamilyPlans {
                let subTitleSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(80))
                // Add the Section Title
                let subTitle = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: subTitleSize,
                    elementKind: SectionSubTitleCell.identifier,
                    alignment: .top)

                section.boundarySupplementaryItems = [subTitle]
            }

            return section
        })
        return layout
    }

    func configureDataSource() {

        // MARK: Register the cells
        // IMPORTANT - IN ORDER FOR ESTIMATED LAYOUTS TO WORK YOU MUST DO ALL THE CELL CONFIGURATION WITH THE CELL REGISTRATION.

        // please note that this is the equivalent of "cellForItemAt"
        // Except the cells do not need to be deQueued.

        /// SectionTitleCellRegistration Cell
        let SectionTitleCellRegistration = UICollectionView.CellRegistration
        <SectionTitleCell, Int> { (cell, indexPath, _) in
            guard let currentContent = LanguageCoordinator.shared.currentContent else {
                return
            }
            let title: String

            switch Offering.Sections[indexPath.section] {
            case .consumablesTitle:
                title = currentContent.shared.consumables
                break
            case .nonConsumablesTitle:
                title = currentContent.shared.nonConsumables
                break
            case .nonRenewingSubscriptionsTitle:
                title = currentContent.shared.nonRenewingSubscriptions
                break
            case .autoRenewableSubscriptionsTitle:
                title = currentContent.shared.autoRenewingSubscriptions
                break
            case .restorePurchasesTitle:
                title = currentContent.offering.restorePurchasesPrompt
            default:
                // This should never occur
                title = currentContent.shared.error
                break
            }
            DispatchQueue.main.async {
                cell.update(text: title)
                cell.setNeedsLayout()
                cell.layoutIfNeeded()
            }
        }

        let SectionSubTitleSupplementaryRegistration = UICollectionView.SupplementaryRegistration<SectionSubTitleCell>(elementKind: SectionSubTitleCell.identifier) { (cell, _, indexPath) in
            DispatchQueue.main.async {
                guard let currentContent = LanguageCoordinator.shared.currentContent else {
                    return
                }
                let title: String

                switch Offering.Sections[indexPath.section] {
                case .autoRenewableSubscriptionsIndividualPlans:
                    title = currentContent.shared.individualPlans
                    break
                case .autoRenewableSubscriptionsFamilyPlans:
                    title = currentContent.shared.familyPlans
                    break
                default:
                    // This should never occur
                    title = currentContent.shared.error
                    break
                }

                DispatchQueue.main.async {
                    cell.update(text: title)
                    cell.setNeedsLayout()
                    cell.layoutIfNeeded()
                }
            }
        }

        /// Product Tile Cell
        let ProductTileCellRegistration = UICollectionView.CellRegistration
        <ProductTile, Int> { (cell, indexPath, _) in
            // Configure
            let consumables = StoreKitCoordinator.shared.consumables
            let nonConsumables = StoreKitCoordinator.shared.nonConsumables
            let nonRenewingSubscriptions = StoreKitCoordinator.shared.nonRenewables
            let individualSubscriptions = StoreKitCoordinator.shared.individualSubscriptions
            let familySubscriptions = StoreKitCoordinator.shared.familySubscriptions

            let product: Product
            let type: ProductTileType
            switch Offering.Sections[indexPath.section] {
            case .consumables:
                product = consumables[indexPath.row]
                type = .price
                break
            case .nonConsumables:
                product = nonConsumables[indexPath.row]
                type = .get
                break
            case .nonRenewingSubscriptions:
                product = nonRenewingSubscriptions[indexPath.row]
                type = .pending
                break
            case .autoRenewableSubscriptionsIndividualPlans:
                product = individualSubscriptions[indexPath.row]
                type = .autoRenewablePurchased
                break
            case .autoRenewableSubscriptionsFamilyPlans:
                product = familySubscriptions[indexPath.row]
                type = .expiring
                break
            default:
                return
            }
            DispatchQueue.main.async {
                cell.update(type: type, product: product)
                cell.setNeedsLayout()
                cell.layoutIfNeeded()
                // Callbacks
                cell.onRelease = { [weak self] in
                    guard let _ = self else { return }
                    debugPrint("\(Offering.identifier) ProductTileCellRegistration onRelease \(DebuggingIdentifiers.actionOrEventSucceded) User pressed the button with type : \(type) on product : \(product.displayName)")
                }
            }
        }

        /// RedeemOfferCell
        let OfferCodesAndRefundsCellRegistration = UICollectionView.CellRegistration
        <OfferCodesAndRefundsCell, Int> { (cell, _, _) in
            DispatchQueue.main.async {
                cell.update()
                cell.setNeedsLayout()
                cell.layoutIfNeeded()
                // Callbacks
                cell.onRedeemOfferCode = { [weak self] in
                    guard let _ = self else { return }
                    debugPrint("\(Offering.identifier) OfferCodesAndRefundsCellRegistration onRedeemOfferCode \(DebuggingIdentifiers.actionOrEventSucceded) User pressed onRedeemOfferCode.")
                }

                cell.onRequestARefund = { [weak self] in
                    guard let _ = self else { return }
                    debugPrint("\(Offering.identifier) OfferCodesAndRefundsCellRegistration onRequestARefund \(DebuggingIdentifiers.actionOrEventSucceded) User pressed onRequestARefund.")
                }
            }

        }

        /// Restore Purchases Cell
        let RestorePurchasesCellRegistration = UICollectionView.CellRegistration
        <RestorePurchasesCell, Int> { (cell, _, _) in
            DispatchQueue.main.async {
                cell.update()
                cell.setNeedsLayout()
                cell.layoutIfNeeded()
                // Callbacks
                cell.onRelease = { [weak self] in
                    guard let _ = self else { return }
                    debugPrint("\(Offering.identifier) RestorePurchasesCellRegistration onRelease \(DebuggingIdentifiers.actionOrEventSucceded) User pressed restore purchases.")
                }
            }
        }

        // MARK: Create the datasource and tie it to the collectionView.
        // This is the part that ties the function above to your collectionview
        dataSource = UICollectionViewDiffableDataSource
        <StoreKitOfferingSections, Int>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, item: Int) -> UICollectionViewCell? in
            switch Offering.Sections[indexPath.section] {
            case .consumablesTitle, .nonConsumablesTitle, .nonRenewingSubscriptionsTitle, .autoRenewableSubscriptionsTitle, .restorePurchasesTitle:
                return collectionView.dequeueConfiguredReusableCell(using: SectionTitleCellRegistration, for: indexPath, item: item)
            case .offerCodesAndRefunds:
                return collectionView.dequeueConfiguredReusableCell(using: OfferCodesAndRefundsCellRegistration, for: indexPath, item: item)
            case .restorePurchases:
                return collectionView.dequeueConfiguredReusableCell(using: RestorePurchasesCellRegistration, for: indexPath, item: item)
            case .consumables, .nonConsumables, .nonRenewingSubscriptions, .autoRenewableSubscriptionsIndividualPlans, .autoRenewableSubscriptionsFamilyPlans:
                return collectionView.dequeueConfiguredReusableCell(using: ProductTileCellRegistration, for: indexPath, item: item)
            }
        }
        // Add the supplementary views (i.e. the header or footer)
        dataSource.supplementaryViewProvider = { (_, _, index) in
            return self.collectionView.dequeueConfiguredReusableSupplementary(
                using: SectionSubTitleSupplementaryRegistration, for: index)
        }
    }

    func setDataSourceData() {

        // MARK: Load the data
        var snapshot = NSDiffableDataSourceSnapshot<StoreKitOfferingSections, Int>()
        snapshot.appendSections(Offering.Sections)

        let consumables = StoreKitCoordinator.shared.consumables
        let nonConsumables = StoreKitCoordinator.shared.nonConsumables
        let nonRenewingSubscriptions = StoreKitCoordinator.shared.nonRenewables
        let individualSubscriptions = StoreKitCoordinator.shared.individualSubscriptions
        let familySubscriptions = StoreKitCoordinator.shared.familySubscriptions

        guard !consumables.isEmpty && !nonConsumables.isEmpty && !nonRenewingSubscriptions.isEmpty && !individualSubscriptions.isEmpty && !familySubscriptions.isEmpty else { return }
        let consumablesCount = consumables.count
        let totalConsumables = consumablesCount + nonConsumables.count
        let totalConsumablesAndNonRenewing = totalConsumables + nonRenewingSubscriptions.count
        let totalIAPAndIndividualPlans = totalConsumablesAndNonRenewing + individualSubscriptions.count
        let totalProducts = totalIAPAndIndividualPlans + familySubscriptions.count

        // Consumables
        snapshot.appendItems([0], toSection: .consumablesTitle)
        snapshot.appendItems([Int](1...consumablesCount), toSection: .consumables)
        // Non-Consumables
        snapshot.appendItems([consumablesCount + 1], toSection: .nonConsumablesTitle)
        snapshot.appendItems([Int](consumablesCount + 2...totalConsumables + 1), toSection: .nonConsumables)
        // Non-Renewing Subscriptions
        snapshot.appendItems([totalConsumables + 2], toSection: .nonRenewingSubscriptionsTitle)
        snapshot.appendItems([Int](totalConsumables + 3...totalConsumablesAndNonRenewing + 2), toSection: .nonRenewingSubscriptions)
        // Auto-Renewable Subscriptions
        snapshot.appendItems([totalConsumablesAndNonRenewing + 3], toSection: .autoRenewableSubscriptionsTitle)
        snapshot.appendItems([Int](totalConsumablesAndNonRenewing + 4...totalIAPAndIndividualPlans + 3), toSection: .autoRenewableSubscriptionsIndividualPlans)
        snapshot.appendItems([Int](totalIAPAndIndividualPlans + 4...totalProducts + 3), toSection: .autoRenewableSubscriptionsFamilyPlans)
        // Offer Codes & Refunds
        snapshot.appendItems([totalProducts + 4], toSection: .offerCodesAndRefunds)
        snapshot.appendItems([totalProducts + 5], toSection: .restorePurchasesTitle)
        snapshot.appendItems([totalProducts + 6], toSection: .restorePurchases)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}
