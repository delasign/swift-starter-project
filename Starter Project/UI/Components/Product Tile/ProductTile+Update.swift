//
//  ProductTile+Update.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 3/9/23.
//

import Foundation
import UIKit

extension ProductTile {
    func update() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            guard let _ = LanguageCoordinator.shared.currentContent, let product = self.product else {
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

            // Button
            self.purchaseButton.configure(type: purchaseButtonType, product: product)
            // Product Title
            self.productTitle.attributedText = Styleguide.attributedProductTitleText(text: product.displayName)
            self.productTitle.sizeToFit()
            // Product Description
            self.productDescription.attributedText = Styleguide.attributedProductDescriptionText(text: product.description)
            self.productDescription.sizeToFit()
            self.invalidateIntrinsicContentSize()
        }

    }
}
