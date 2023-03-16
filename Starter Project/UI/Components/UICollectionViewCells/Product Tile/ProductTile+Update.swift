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
        guard let product = self.product, let currentContent = LanguageCoordinator.shared.currentContent else {
            return
        }

        var purchaseButtonType: PurchaseButtonType?
        var detailString: String?
        var buttonString: String?
        switch self.type {
        case .get:
            purchaseButtonType = .free
            buttonString = currentContent.productTile.get
            break
        case .price:
            purchaseButtonType = .price
            buttonString = currentContent.productTile.purchase
            break
        case .consumableBuy:
            purchaseButtonType = .price
            detailString = currentContent.productTile.stock + "\(0)"
            buttonString = currentContent.productTile.purchase
            break
        case .buyMonthly, .buyYearly, .buyIntroOfferMonthly:
            purchaseButtonType = .price
            buttonString = currentContent.productTile.purchase
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
            buttonString = currentContent.productTile.claimOffer
            break
        case .refund:
            buttonString = currentContent.shared.requestARefund
            break
        case .refundSubscription:
            buttonString = currentContent.shared.requestARefund
            break
        }

        // Button
        if let purchaseButtonType = purchaseButtonType {
            self.purchaseButton.configure(type: purchaseButtonType, product: product)
            self.purchaseButton.isHidden = false
        } else {
            self.purchaseButton.isHidden = true
        }

        // Product Title
        self.productTitle.attributedText = Styleguide.attributedProductTitleText(text: product.displayName)
        self.productTitle.sizeToFit()
        // Product Description
        self.productDescription.attributedText = Styleguide.attributedProductDescriptionText(text: product.description)
        self.productDescription.sizeToFit()

        //            // Hide / Show Detail Label
        //            if let detailString = detailString {
        //                self.productDetailTopToBottomConstraint?.constant = kPadding
        //                self.productDetail.attributedText = Styleguide.attributedProductDetailText(text: detailString)
        //            } else {
        //                self.productDetailTopToBottomConstraint?.constant = 0
        //            }
        //
        //            // Hide / Show Action Button
        //            if let buttonString = buttonString {
        //                self.actionButtonTopToBottomConstraint?.constant = kPadding
        //                self.actionButton.heightConstraint?.constant = kButtonDimension
        //                self.actionButton.title.attributedText = Styleguide.attributedProductButtonText(text: buttonString, color: Styleguide.colors.white)
        //                self.actionButton.isHidden = false
        //            } else {
        //                self.actionButtonTopToBottomConstraint?.constant = 0
        //                self.actionButton.heightConstraint?.constant = 0
        //                self.actionButton.isHidden = true
        //            }
        //
        //            self.setNeedsLayout()
        //            self.layoutIfNeeded()
    }
}
