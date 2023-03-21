//
//  Refund+CollectionView.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 3/16/23.
//

import Foundation
import UIKit
import StoreKit

extension Refund {

    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { (sectionIndex, _) -> NSCollectionLayoutSection? in
            let currentSection = self.dataSource.sectionIdentifier(for: sectionIndex) // Refund.Sections[sectionIndex]
            // Determine the size of each cell.
            // Please note that we have chosen to do the subscription individual plans and family plans as a section, as the layout does not re-render itself.
            let itemWidth: NSCollectionLayoutDimension = .fractionalWidth(1)
            let itemHeight: NSCollectionLayoutDimension
            let contentInsetConstant: CGFloat
            switch currentSection {
            case .consumablesTitle, .nonConsumablesTitle, .nonRenewingSubscriptionsTitle, .autoRenewableSubscriptionsTitle:
                itemHeight = .estimated(120)
                contentInsetConstant = 0
                break
            case .consumables, .nonConsumables, .nonRenewingSubscriptions, .autoRenewableSubscriptionsIndividualPlans, .autoRenewableSubscriptionsFamilyPlans:
                itemHeight = .estimated(250)
                contentInsetConstant = kPadding
                break
            case .autoRenewableSubscriptionsIndividualPlansTitle, .autoRenewableSubscriptionsFamilyPlansTitle:
                itemHeight = .estimated(80)
                contentInsetConstant = kPadding
            default:
                return nil
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

            switch self.dataSource.sectionIdentifier(for: indexPath.section) {
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
        /// SectionSubTitleCellRegistration Cell
        let SectionSubTitleCellRegistration = UICollectionView.CellRegistration
        <SectionSubTitleCell, Int> { (cell, indexPath, _) in
            DispatchQueue.main.async {
                guard let currentContent = LanguageCoordinator.shared.currentContent else {
                    return
                }
                let title: String

                switch self.dataSource.sectionIdentifier(for: indexPath.section) {
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
            let consumables = StoreKitCoordinator.shared.purchasedConsumables
            let nonConsumables = StoreKitCoordinator.shared.purchasedNonConsumables
            let nonRenewingSubscriptions = StoreKitCoordinator.shared.purchasedNonRenewables
            let individualSubscriptions = StoreKitCoordinator.shared.purchasedIndividualSubscriptions
            let familySubscriptions = StoreKitCoordinator.shared.purchasedFamilySubscriptions

            let product: Product
            let type: ProductTileType = .refund
            switch self.dataSource.sectionIdentifier(for: indexPath.section) {
            case .consumables:
                product = consumables[indexPath.row]
                break
            case .nonConsumables:
                product = nonConsumables[indexPath.row]
                break
            case .nonRenewingSubscriptions:
                product = nonRenewingSubscriptions[indexPath.row]
                break
            case .autoRenewableSubscriptionsIndividualPlans:
                product = individualSubscriptions[indexPath.row]
                break
            case .autoRenewableSubscriptionsFamilyPlans:
                product = familySubscriptions[indexPath.row]
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

        // MARK: Create the datasource and tie it to the collectionView.
        // This is the part that ties the function above to your collectionview
        dataSource = UICollectionViewDiffableDataSource
        <StoreKitOfferingSections, Int>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, item: Int) -> UICollectionViewCell? in
            switch Refund.Sections[indexPath.section] {
            case .consumablesTitle, .nonConsumablesTitle, .nonRenewingSubscriptionsTitle, .autoRenewableSubscriptionsTitle, .restorePurchasesTitle:
                return collectionView.dequeueConfiguredReusableCell(using: SectionTitleCellRegistration, for: indexPath, item: item)
            case .consumables, .nonConsumables, .nonRenewingSubscriptions, .autoRenewableSubscriptionsIndividualPlans, .autoRenewableSubscriptionsFamilyPlans:
                return collectionView.dequeueConfiguredReusableCell(using: ProductTileCellRegistration, for: indexPath, item: item)
            case .autoRenewableSubscriptionsIndividualPlansTitle, .autoRenewableSubscriptionsFamilyPlansTitle:
                return collectionView.dequeueConfiguredReusableCell(using: SectionSubTitleCellRegistration, for: indexPath, item: item)
            default:
                return nil
            }
        }
    }

    func setDataSourceData() {

        let consumables = StoreKitCoordinator.shared.purchasedConsumables
        let nonConsumables = StoreKitCoordinator.shared.purchasedNonConsumables
        let nonRenewingSubscriptions = StoreKitCoordinator.shared.purchasedNonRenewables
        let individualSubscriptions = StoreKitCoordinator.shared.purchasedIndividualSubscriptions
        let familySubscriptions = StoreKitCoordinator.shared.purchasedFamilySubscriptions

        // Determine Count
        let consumablesCount = consumables.count
        let totalConsumables = consumablesCount + nonConsumables.count
        let totalConsumablesAndNonRenewing = totalConsumables + nonRenewingSubscriptions.count
        let totalIAPAndIndividualPlans = totalConsumablesAndNonRenewing + individualSubscriptions.count
        let totalProducts = totalIAPAndIndividualPlans + familySubscriptions.count

        // Determine availability
        let refundConsumables = !consumables.isEmpty
        let refundNonConsumables = !nonConsumables.isEmpty
        let refundNonRenewing = !nonRenewingSubscriptions.isEmpty
        let refundIndividualSubscriptions = !individualSubscriptions.isEmpty
        let refundFamilySubscriptions = !familySubscriptions.isEmpty

        // MARK: Load the data
        var snapshot = NSDiffableDataSourceSnapshot<StoreKitOfferingSections, Int>()
        var sections: [StoreKitOfferingSections] = []

        if refundConsumables {
            sections.append(.consumablesTitle)
            sections.append(.consumables)
        }
        if refundNonConsumables {
            sections.append(.nonConsumablesTitle)
            sections.append(.nonConsumables)
        }
        if refundNonRenewing {
            sections.append(.nonRenewingSubscriptionsTitle)
            sections.append(.nonRenewingSubscriptions)
        }
        if refundIndividualSubscriptions || refundFamilySubscriptions {
            sections.append(.autoRenewableSubscriptionsTitle)
        }
        if refundIndividualSubscriptions {
            sections.append(.autoRenewableSubscriptionsIndividualPlansTitle)
            sections.append(.autoRenewableSubscriptionsIndividualPlans)
        }
        if refundFamilySubscriptions {
            sections.append(.autoRenewableSubscriptionsFamilyPlansTitle)
            sections.append(.autoRenewableSubscriptionsFamilyPlans)
        }

        snapshot.appendSections(sections)

        // Add Relevant Sections
        if refundConsumables {
            snapshot.appendItems([0], toSection: .consumablesTitle)
            snapshot.appendItems([Int](1...consumablesCount), toSection: .consumables)
        }

        if refundNonConsumables {
            // Non-Consumables
            snapshot.appendItems([consumablesCount + 1], toSection: .nonConsumablesTitle)
            snapshot.appendItems([Int](consumablesCount + 2...totalConsumables + 1), toSection: .nonConsumables)
        }

        if refundNonRenewing {
            // Non-Renewing Subscriptions
            snapshot.appendItems([totalConsumables + 2], toSection: .nonRenewingSubscriptionsTitle)
            snapshot.appendItems([Int](totalConsumables + 3...totalConsumablesAndNonRenewing + 2), toSection: .nonRenewingSubscriptions)
        }

        if refundIndividualSubscriptions || refundFamilySubscriptions {
            // Auto-Renewable Subscriptions
            snapshot.appendItems([totalConsumablesAndNonRenewing + 3], toSection: .autoRenewableSubscriptionsTitle)
        }

        if refundIndividualSubscriptions {
            // Individual Plans
            snapshot.appendItems([totalConsumablesAndNonRenewing + 4], toSection: .autoRenewableSubscriptionsIndividualPlansTitle)
            snapshot.appendItems([Int](totalConsumablesAndNonRenewing + 5...totalIAPAndIndividualPlans + 4), toSection: .autoRenewableSubscriptionsIndividualPlans)
        }

        if refundFamilySubscriptions {
            // Family Plans
            snapshot.appendItems([totalIAPAndIndividualPlans + 5], toSection: .autoRenewableSubscriptionsFamilyPlansTitle)
            snapshot.appendItems([Int](totalIAPAndIndividualPlans + 6...totalProducts + 5), toSection: .autoRenewableSubscriptionsFamilyPlans)
        }
        // Snapshots must be applied on the main queue
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
}
