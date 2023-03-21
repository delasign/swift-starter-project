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
            // Determine the size of each cell.
            // Please note that in the offering we have created the titles for the individual and family plans using a supplementary header.
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
            // Add the supplementary header to the individual and family plans
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
            }
        }
        /// SectionSubTitleCell Supplementary Registration
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
                }
            }
        }

        /// Product Tile Cell
        let ProductTileCellRegistration = UICollectionView.CellRegistration
        <ProductTile, Int> { (cell, indexPath, _) in
            Task { [weak cell] in
                guard let cell = cell else { return }
                // Configure
                let skc = StoreKitCoordinator.shared
                let consumables = skc.consumables
                let nonConsumables = skc.nonConsumables
                let nonRenewingSubscriptions = skc.nonRenewables
                let individualSubscriptions = skc.individualSubscriptions
                let familySubscriptions = skc.familySubscriptions

                let product: Product
                var type: ProductTileType = .price

                switch Offering.Sections[indexPath.section] {
                case .consumables:
                    product = consumables[indexPath.row]
                    // Consumables are always available, and always have a price.
                    // There are two states that can be available:
                    // - Purchase is pending - This cannot be checked through the Swift StoreKit2 library and requires App Store Server Notifications or a custom solution to acknowledge this at load time.
                    // - Buyable
                    type = .consumableBuy
                    break
                case .nonConsumables:
                    product = nonConsumables[indexPath.row]
                    // Non Consumables are either purchased or if not purchased, pending or available for purchase.
                    if skc.isPurchased(product) {
                        type = .purchased
                    } else {
                        //  Purchase is pending cannot be checked through the Swift StoreKit2 library and requires App Store Server Notifications or a custom solution to acknowledge this at load time.
                        // Non Consumables always carry a price tag but can be free. If they are free, their price tag is 0.00.
                        type = product.price < 0.01 ? .get : .price
                    }
                    break
                case .nonRenewingSubscriptions:
                    product = nonRenewingSubscriptions[indexPath.row]
                    // Non Renewing Subscriptions are either purchased, pending or available for purchase.
                    if skc.isPurchased(product) {
                        // In the case that a non-renewable has been purchased, it is active until a date.
                        type = .activeUntil
                    } else {
                        //  Purchase is pending cannot be checked through the Swift StoreKit2 library and requires App Store Server Notifications or a custom solution to acknowledge this at load time.
                        // Non-renewables are never free and always carry a price (i.e. they can never be free).
                        type = .price
                    }
                    break
                case .autoRenewableSubscriptionsIndividualPlans:
                    product = individualSubscriptions[indexPath.row]
                    // Auto Renewing Subscriptions are either purchased, in billing retry, in a grace period, expiring, pending or available for purchase.
                    // If they are available for purchase, they can have an introductory offer or a promotional offer.
                    // Promotional Offers are not covered by this tutorial.
                    type = await self.getSubscriptionProductTileType(product: product)
                    break
                case .autoRenewableSubscriptionsFamilyPlans:
                    product = familySubscriptions[indexPath.row]
                    // Auto Renewing Subscriptions are either purchased, expiring, in billing retry, in a grace period, pending or available for purchase.
                    // If they are available for purchase, they can have an introductory offer or a promotional offer.
                    // Promotional Offers are not covered by this tutorial.
                    type = await self.getSubscriptionProductTileType(product: product)
                    break
                default:
                    return
                }
                DispatchQueue.main.async { [weak cell] in
                    guard let cell = cell else { return }
                    cell.update(type: type, product: product)
                    // Callbacks
                    cell.onRelease = { [weak self] in
                        guard let _ = self else { return }
                        debugPrint("\(Offering.identifier) ProductTileCellRegistration onRelease \(DebuggingIdentifiers.actionOrEventSucceded) User pressed the button with type : \(type) on product : \(product.displayName).")

                        switch type {
                        // Allow for all types of purchasables as they can update outside of the closure. This is to avoid a situation where they can't upgrade and downgrade in a circular fashion within the same screen.
                        case .get, .price, .consumableBuy, .buySubscription, .buySubscriptionWithIntroductoryOffer, .autoRenewablePurchased, .purchased:
                            // Only allow those that have not been purchased
                            guard !StoreKitCoordinator.shared.isPurchased(product) else {
                                debugPrint("\(Offering.identifier) ProductTileCellRegistration onRelease \(DebuggingIdentifiers.actionOrEventSucceded) Did not execute anything - [Product has already been purchased].")
                                return
                            }
                            // Execute Purchase
                            Task {
                                do {
                                    _ = try await StoreKitCoordinator.shared.purchase(product)
                                } catch {
                                    debugPrint("\(Offering.identifier) ProductTileCellRegistration onRelease \(DebuggingIdentifiers.actionOrEventSucceded) failed to buy product : \(product.displayName). Error : \(error.localizedDescription)")
                                }
                            }
                            break
                        default:
                            debugPrint("\(Offering.identifier) ProductTileCellRegistration onRelease \(DebuggingIdentifiers.actionOrEventSucceded) Did not execute anything - [Default State].")
                            break
                        }
                    }
                }

            }

        }

        /// RedeemOfferCell
        let OfferCodesAndRefundsCellRegistration = UICollectionView.CellRegistration
        <OfferCodesAndRefundsCell, Int> { (cell, _, _) in
            DispatchQueue.main.async {
                cell.update()
                // Layout to make sure that the cell resizes correctly.
                cell.setNeedsLayout()
                cell.layoutIfNeeded()
                // Callbacks
                cell.onRedeemOfferCode = { [weak self] in
                    guard let _ = self else { return }
                    debugPrint("\(Offering.identifier) OfferCodesAndRefundsCellRegistration onRedeemOfferCode \(DebuggingIdentifiers.actionOrEventSucceded) User pressed onRedeemOfferCode.")
                }

                cell.onRequestARefund = { [weak self] in
                    guard let self = self else { return }
                    debugPrint("\(Offering.identifier) OfferCodesAndRefundsCellRegistration onRequestARefund \(DebuggingIdentifiers.actionOrEventSucceded) User pressed onRequestARefund.")
                    // Send Notification
                    NotificationCenter.default.post(name: SystemNotifications.updateExperienceState, object: nil, userInfo: [kExperienceStateUserInfo: ExperienceStates.refund])
                    // Scroll to the top after a small delay
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5 / 30, execute: { [weak self] in
                        guard let self = self else { return }
                        self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
                    })
                }
            }
        }

        /// Restore Purchases Cell
        let RestorePurchasesCellRegistration = UICollectionView.CellRegistration
        <RestorePurchasesCell, Int> { (cell, _, _) in
            DispatchQueue.main.async {
                cell.update()
                // Layout to make sure that the cell resizes correctly.
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
            default:
                return nil
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

        // Snapshots must be applied on the main queue
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.dataSource.apply(snapshot, animatingDifferences: false)
        }
    }
}
