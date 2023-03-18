//
//  TransactionLabel+UI.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 3/8/23.
//

import Foundation
import UIKit
import TinyConstraints

extension TransactionLabel {
    // The setupUI function should be the only publically available class in this extension.
    // This can be called refreshUI if your app removes and adds content periodically.
    func setupUI() {
        switch type {
        case .free, .price, .subscriptionPrice, .introductoryOffer:
            self.setupLabel()
            break
        case .pending:
            self.setupImageView(image: Images.pending,
                                color: Styleguide.colors.white,
                                width: 74,
                                height: 22
            )
            break
        case .purchased:
            self.setupImageView(image: Images.success,
                                color: Styleguide.colors.white,
                                width: 30,
                                height: 30
            )
            break
        case .warning:
            self.setupImageView(image: Images.warning,
                                color: Styleguide.colors.white,
                                width: 30,
                                height: 30
            )
            break
        }

    }

    // MARK: UI Setup Functionality
    private func setupLabel() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self, let currentContent = LanguageCoordinator.shared.currentContent else { return }
            self.addSubview(self.label)
            self.label.edgesToSuperview()

            let copy: String
            var color: UIColor = Styleguide.colors.black
            switch self.type {
            case .free:
                copy = currentContent.transactionLabel.free
                break
            case .price:
                if let product = self.product {
                    copy = product.displayPrice
                } else {
                    copy = currentContent.shared.missing
                }
                break
            case .subscriptionPrice:
                if let product = self.product {
                    // Get the subscriptionPeriodString
                    let subscriptionPeriodString = getStoreKitSubscriptionPeriodString(product: product)
                    // Set the copy
                    copy = "\(product.displayPrice)/\n\(subscriptionPeriodString)"

                } else {
                    copy = currentContent.shared.missing
                }
                break
            case .introductoryOffer:
                color = Styleguide.colors.white
                if let product = self.product, let introductoryOffer = product.subscription?.introductoryOffer {
                    // Get the subscriptionPeriodString
                    let subscriptionPeriodString = getStoreKitSubscriptionIntroductoryOfferPeriodString(product: product)
                    // Set the copy
                    copy = "\(introductoryOffer.displayPrice)/\n\(subscriptionPeriodString)"
                } else {
                    copy = currentContent.shared.missing
                }
                break
            default:
                copy = currentContent.shared.error
                break
            }

            if self.type == .subscriptionPrice || self.type == .introductoryOffer {
                self.label.attributedText = Styleguide.attributedTransactionLabelTextSmall(text: copy, color: color)
            } else {
                self.label.attributedText = Styleguide.attributedLabelText(text: copy, color: color)
            }

        }
    }

    private func setupImageView(image: String, color: UIColor, width: CGFloat, height: CGFloat) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.addSubview(self.imageView)
            self.imageView.centerInSuperview()
            self.imageView.image = UIImage(named: image)?.withRenderingMode(.alwaysTemplate)
            self.imageView.tintColor = color
            if let _ = self.imageViewWidth {
                self.imageViewWidth?.constant = width
            } else {
                self.imageViewWidth = self.imageView.width(width)
            }

            if let _ = self.imageViewHeight {
                self.imageViewHeight?.constant = height
            } else {
                self.imageViewHeight = self.imageView.height(height)
            }
        }
    }
}
