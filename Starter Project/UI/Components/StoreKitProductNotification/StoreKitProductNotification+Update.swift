//
//  StoreKitProductNotification+Update.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 3/21/23.
//

import Foundation
import UIKit
import StoreKit

extension StoreKitProductNotification {
    func update() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self, let currentContent = LanguageCoordinator.shared.currentContent?.notifications else { return }
            // Update the background color
            self.backgroundColor = self.getBackgroundColor()
            // Get the label & image
            let copy: String
            let image: String
            let imageWidth: CGFloat
            let imageHeight: CGFloat
            switch self.type {
            case .purchased:
                guard let product = self.product else { return }
                copy = currentContent.success + product.displayName + currentContent.successSuffix
                image = Images.success
                imageWidth = 30
                imageHeight = 30
                break
            case.pending:
                guard let product = self.product else { return }
                copy = currentContent.pendingPrefix + product.displayName + currentContent.pendingSuffix
                image = Images.pending
                imageWidth = 30
                imageHeight = 8
                break
            case .failed:
                guard let product = self.product else { return }
                copy = currentContent.failedPrefix + product.displayName + currentContent.failedSuffix
                image = Images.warning
                imageWidth = 30
                imageHeight = 30
                break
            case .refundSucceeded:
                guard let product = self.product else { return }
                copy = currentContent.refundSucceededPrefix + product.displayName + currentContent.refundSucceededSuffix
                image = Images.success
                imageWidth = 30
                imageHeight = 30
                break
            case.refundPending:
                guard let product = self.product else { return }
                copy = currentContent.refundPendingPrefix + product.displayName + currentContent.refundPendingSuffix
                image = Images.pending
                imageWidth = 30
                imageHeight = 8
                break
            case .refundFailed:
                guard let product = self.product else { return }
                copy = currentContent.refundFailedPrefix + product.displayName + currentContent.refundFailedSuffix
                image = Images.warning
                imageWidth = 30
                imageHeight = 30
                break
            case .refundCancelled:
                guard let product = self.product else { return }
                copy = currentContent.refundCancelledPrefix + product.displayName + currentContent.refundCancelledSuffix
                image = Images.success
                imageWidth = 30
                imageHeight = 30
                break
            }

            // Update Label
            self.label.attributedText = Styleguide.attributedProductDetailText(text: copy, color: Styleguide.colors.white)
            self.label.sizeToFit()
            // Update ImageView
            self.imageView.image = UIImage(named: image)?.withRenderingMode(.alwaysTemplate)
            self.imageView.tintColor = Styleguide.colors.white
            self.imageViewWidth?.constant = imageWidth
            self.imageViewHeight?.constant = imageHeight
            // Update Height
            let height = self.label.frame.height + 2 * kPadding
            self.heightConstraint?.constant = height
            self.layer.cornerRadius = height / 2
            // Update constraints
            self.setNeedsLayout()
            self.layoutIfNeeded()
            // Animate in
            self.animateIn()
            // Show for 2 seconds and animate out
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: { [weak self] in
                guard let self = self else { return }
                self.animateOut()
            })
        }
    }
}
