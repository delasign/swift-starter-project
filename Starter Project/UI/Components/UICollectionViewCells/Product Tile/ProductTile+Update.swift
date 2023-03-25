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
    func update(collectionViewType: StoreKitTutorialCollectionViewType, type: ProductTileType, product: Product) {
        // Update Data Points
        self.collectionViewType = collectionViewType
        self.type = type
        self.product = product
        // Update Visual
        Task { [weak self] in
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
                // Non-Renewing Dates are based on Business Logic
                // This implies that you must remove non-renewables after they become "Not Valid" and create another one if needed, with different logic and circumstances.
                detailString = currentContent.productTile.nonRenewingActiveUntil
                break
            case .autoRenewablePurchased:
                transactionLabelType = .purchased
                let renewalDate = await StoreKitCoordinator.shared.getSubscriptionRenewalOrExpirationDate(product: product)
                detailString = currentContent.productTile.autoRenewableRenewsOn + renewalDate + "."
                buttonString = currentContent.productTile.manageSubscription
                break
            case .gracePeriod:
                transactionLabelType = .warning
                detailString = currentContent.productTile.autoRenewableGracePeriod
                break
            case .billingRetry:
                transactionLabelType = .warning
                detailString = currentContent.productTile.autoRenewableBillingRetry
                buttonString = currentContent.productTile.manageSubscription
                break
            case .expiring:
                transactionLabelType = .warning
                let expirationDate = await StoreKitCoordinator.shared.getSubscriptionRenewalOrExpirationDate(product: product)
                detailString = currentContent.productTile.autoRenewableWillExpire + expirationDate + currentContent.productTile.autoRenewableWillExpireMessage
                buttonString = currentContent.productTile.claimOffer
                break
            case .refund:
                buttonString = currentContent.shared.requestARefund
                break
            case .refundSubscription:
                buttonString = currentContent.shared.requestARefund
                break
            }

            DispatchQueue.main.async { [weak self] in
                guard let self = self else {
                    return
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
                    self.productDetail.sizeToFit()
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
                    self.productDetail.sizeToFit()
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
                // Layout to make sure that the cell resizes correctly.
                self.setNeedsLayout()
                self.layoutIfNeeded()
            }
        }
    }
}
