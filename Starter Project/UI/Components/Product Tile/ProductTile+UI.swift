//
//  ProductTile+UI.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 3/8/23.
//

import Foundation
import UIKit

extension ProductTile {
    func setupUI() {
        guard let _ = LanguageCoordinator.shared.currentContent, let _ = self.product else {
            return
        }

        let purchaseButtonType: PurchaseButtonType
        switch self.type {
        case .get:
            purchaseButtonType = .get
            break
        case .price, .consumableBuy, .buyMonthly, .buyYearly, .buyIntroOfferMonthly:
            purchaseButtonType = .price
            break
        case .pending:
            purchaseButtonType = .pending
            break
        case .purchased:
            purchaseButtonType = .purchased
            break
        case .activeUntil:
            purchaseButtonType = .purchased
            break
        case .autoRenewablePurchased:
            purchaseButtonType = .purchased
            break
        case .gracePeriod:
            purchaseButtonType = .warning
            break
        case .expiring:
            purchaseButtonType = .warning
            break
        case .refund:
            purchaseButtonType = .refund
            break
        case .refundSubscription:
            purchaseButtonType = .refund
            break
        }

        self.setupPurchaseButton(type: purchaseButtonType)
        self.setupProductTitle()
        self.setupProductDescription()
    }

    // MARK: UI Setup Functionality
    private func setupPurchaseButton(type: PurchaseButtonType) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let purchaseButton = PurchaseButton(type: type, product: self.product)
            self.addSubview(purchaseButton)
            self.purchaseButton = purchaseButton
            self.purchaseButton?.top(to: self, offset: kPadding)
            self.purchaseButton?.right(to: self, offset: -kPadding)
        }
    }

    private func setupProductTitle() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self, let product = self.product, let purchaseButton = self.purchaseButton else { return }
            self.addSubview(self.productTitle)
            self.productTitle.top(to: self, offset: kPadding)
            self.productTitle.left(to: self, offset: kPadding)
            self.productTitle.rightToLeft(of: purchaseButton, offset: -kPadding)
            self.productTitle.attributedText = Styleguide.attributedProductTitleText(text: product.displayName)
        }
    }

    private func setupProductDescription() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self, let product = self.product, let purchaseButton = self.purchaseButton else { return }
            self.addSubview(self.productDescription)
            self.productDescription.topToBottom(of: self.productTitle, offset: kPadding)
            self.productDescription.left(to: self, offset: kPadding)
            self.productDescription.rightToLeft(of: purchaseButton, offset: -kPadding)
            self.productDescription.attributedText = Styleguide.attributedProductDescriptionText(text: product.description)
        }
    }
}
