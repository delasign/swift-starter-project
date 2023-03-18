//
//  ProductTile+Update.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 3/9/23.
//

import Foundation
import UIKit
import StoreKit

extension ProductTile {
    func update(type: ProductTileType, product: Product) {
        // Update Data Points
        self.type = type
        self.product = product
        // Update Visual
        DispatchQueue.main.async { [weak self] in
            guard let self = self, let product = self.product, let currentContent = LanguageCoordinator.shared.currentContent else {
                return
            }

            var transactionLabelType: TransactionLabelType?
            var detailString: String?
            var buttonString: String?
            switch self.type {
            case .get:
                transactionLabelType = .free
                buttonString = currentContent.productTile.get
                break
            case .price:
                transactionLabelType = .price
                buttonString = currentContent.productTile.purchase
                break
            case .consumableBuy:
                transactionLabelType = .price
                detailString = currentContent.productTile.stock + "\(0)"
                buttonString = currentContent.productTile.purchase
                break
            case .buySubscription:
                transactionLabelType = .subscriptionPrice
                buttonString = currentContent.productTile.purchase
                break
            case .buySubscriptionWithIntroductoryOffer:
                transactionLabelType = .introductoryOffer
                detailString = getStoreKitIntroductoryOfferDetailString(product: product)
                buttonString = currentContent.productTile.purchase
                break
            case .pending:
                transactionLabelType = .pending
                break
            case .purchased:
                transactionLabelType = .purchased
                break
            case .activeUntil:
                transactionLabelType = .purchased
                break
            case .autoRenewablePurchased:
                transactionLabelType = .purchased
                break
            case .gracePeriod:
                transactionLabelType = .warning
                break
            case .expiring:
                transactionLabelType = .warning
                buttonString = currentContent.productTile.claimOffer
                break
            case .refund:
                buttonString = currentContent.shared.requestARefund
                break
            case .refundSubscription:
                buttonString = currentContent.shared.requestARefund
                break
            }

            // Deactivate relevant transaction label constraints
            deactivateConstraints(constraints: [self.productTitleRightToLeftOfButtonConstraint,
                                                self.productTitleRightToLeftOfButtonConstraint])

            // Show / Hide Button
            if let transactionLabelType = transactionLabelType {
                self.transactionLabel.configure(type: transactionLabelType, product: product)
                self.transactionLabel.isHidden = false
                activateConstraints(constraints: [self.productTitleRightToLeftOfButtonConstraint])
            } else {
                self.transactionLabel.isHidden = true
                activateConstraints(constraints: [self.productTitleRightToLeftOfButtonConstraint])
            }

            // Product Title
            self.productTitle.attributedText = Styleguide.attributedProductTitleText(text: product.displayName)
            self.productTitle.sizeToFit()
            // Product Description
            self.productDescription.attributedText = Styleguide.attributedProductDescriptionText(text: product.description)
            self.productDescription.sizeToFit()

            // Deactivate relevant vertical layout constraints (Product Description, Product Detail and Action Button)
            deactivateConstraints(constraints: [self.productDescriptionBottomToContentViewConstraint,
                                                self.productDetailBottomConstraint,
                                                self.actionButtonLeftConstraint,
                                                self.actionButtonRightConstraint,
                                                self.actionButtonBottomConstraint,
                                                self.actionButtonTopToBottomOfProductDescriptionConstraint,
                                                self.actionButtonTopToBottomOfProductDetailConstraint])

            // MARK: Hide / Show Detail Label
            if let detailString = detailString, buttonString == nil {
                // MARK: Detail, No Button
                // Enable all Product Detail Functionality
                self.productDetail.attributedText = Styleguide.attributedProductDetailText(text: detailString)
                self.productDetail.isHidden = false
                // Disable all action button functionality
                self.actionButton.isHidden = true
                // Activate the Product Detail Bottom Constraint
                activateConstraints(constraints: [self.productDetailBottomConstraint])
            } else if let buttonString = buttonString, detailString == nil {
                // MARK: Button, No Detail
                // Disable all Product Detail Functionality
                self.productDetail.isHidden = true
                // Enable relevant action button functionality
                self.actionButton.title.attributedText = Styleguide.attributedLabelText(text: buttonString, color: Styleguide.colors.white)
                self.actionButton.isHidden = false
                // Activate the Product Detail Bottom Constraint
                activateConstraints(constraints: [self.actionButtonTopToBottomOfProductDescriptionConstraint, self.actionButtonLeftConstraint, self.actionButtonRightConstraint, self.actionButtonBottomConstraint])
                // Add the Action Button On Release
                self.actionButton.onRelease = { [weak self] in
                    guard let self = self else { return }
                    self.onRelease?()
                }
            } else if let buttonString = buttonString, let detailString = detailString {
                // MARK: Button & Detail
                // Enable all Product Detail Functionality
                self.productDetail.attributedText = Styleguide.attributedProductDetailText(text: detailString)
                self.productDetail.isHidden = false
                // Enable relevant action button functionality
                self.actionButton.title.attributedText = Styleguide.attributedLabelText(text: buttonString, color: Styleguide.colors.white)
                self.actionButton.isHidden = false
                // Activate the Product Detail Bottom Constraint
                activateConstraints(constraints: [self.actionButtonTopToBottomOfProductDetailConstraint, self.actionButtonLeftConstraint, self.actionButtonRightConstraint, self.actionButtonBottomConstraint])
                // Add the Action Button On Release
                self.actionButton.onRelease = { [weak self] in
                    guard let self = self else { return }
                    self.onRelease?()
                }
            } else {
                // MARK: Both are Nil
                // Disable all Product Detail functionality
                self.productDetail.isHidden = true
                // Disable all action button functionality
                self.actionButton.isHidden = true
                // Activate the product description bottom constraint
                activateConstraints(constraints: [self.productDescriptionBottomToContentViewConstraint])
            }
        }
    }
}
