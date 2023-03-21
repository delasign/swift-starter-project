//
//  Offering.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 3/7/23.
//

import Foundation
import UIKit
import StoreKit

class Offering: UIView {
    // MARK: Variables
    static let identifier: String = "[Offering]"
    static let Sections: [StoreKitOfferingSections] = [
        .consumablesTitle,
        .consumables,
        .nonConsumablesTitle,
        .nonConsumables,
        .nonRenewingSubscriptionsTitle,
        .nonRenewingSubscriptions,
        .autoRenewableSubscriptionsTitle,
        .autoRenewableSubscriptionsIndividualPlans,
        .autoRenewableSubscriptionsFamilyPlans,
        .offerCodesAndRefunds,
        .restorePurchasesTitle,
        .restorePurchases
    ]
    var dataSource: UICollectionViewDiffableDataSource<StoreKitOfferingSections, Int>!
    // MARK: UI
    var collectionView: UICollectionView!

    // MARK: Lifecycle
    // This is the function that gets called when you initialize your view.
    override init(frame: CGRect) {
        super.init(frame: frame)
        // MARK: UI Specific Setup
        // Before calling your setup functions, call any visual functionality that may be required:
        // i.e. background color, isHidden, isUserInteractionEnabled or translatesAutoresizingMaskIntoConstraints.
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = Styleguide.colors.red
        // MARK: Functionality Setup
        self.setupUI()
        self.setupNotifications()
        self.configureDataSource()
    }

    // This is the function that gets called when you remove your view from its superview.
    override func removeFromSuperview() {
        super.removeFromSuperview()
    }

    // viewWillTransition should be called when the view resizes or changes orientation.
    func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {

    }

    // This function is required for youa custom UIView.
    required init?(coder: NSCoder) {
        fatalError("did not instanstiate coder")
    }

    // MARK: Utilities

    func getSubscriptionProductTileType(product: Product) async -> ProductTileType {
        // Auto Renewing Subscriptions are either purchased, expiring, in billing retry, in a grace period, pending or available for purchase.
        // If they are available for purchase, they can have an introductory offer or a promotional offer.
        // Promotional Offers are not covered by this tutorial.
        let skc = StoreKitCoordinator.shared
        let isPurchased = skc.isPurchased(product)
        let status = await skc.getSubscriptionStatus(product: product)

        if isPurchased {
            // If the product is purchased it can either be:
            // - Purchased and renewing
            // - Expiring (i.e. user cancelled)
            // - In Billing Grace Period
            // - In Billing Retry
            // - Expired - in the event that they are on the screen when the offer expires, otherwise its not purchased

            switch status {
            case .subscribed:
                return .autoRenewablePurchased
            case .expiring:
                return .expiring
            case .inBillingGracePeriod:
                return .gracePeriod
            case .inBillingRetryPeriod:
                return .billingRetry
            case .expired:
                return .buySubscription
            default:
                // In the event that its none of the above, crash (This should never be hit).
                fatalError("\(Offering.identifier) \(DebuggingIdentifiers.actionOrEventFailed) Could not determine valid type.")
            }
        } else {
            // In the event that it has not been purchased, there are two options:
            // - Introductory offer - if one is present and a user has never bought a subscription before.
            // - Buy Subscription - All other cases.
            if product.subscription?.introductoryOffer != nil, await skc.isIntroductoryOfferValid(product: product) {
                return .buySubscriptionWithIntroductoryOffer
            } else {
                return .buySubscription
            }
        }
    }
}
