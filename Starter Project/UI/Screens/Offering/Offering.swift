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
}
