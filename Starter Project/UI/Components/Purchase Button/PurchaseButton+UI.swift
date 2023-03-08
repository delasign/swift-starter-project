//
//  PurchaseButton+UI.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 3/8/23.
//

import Foundation
import UIKit
import TinyConstraints

extension PurchaseButton {
    // The setupUI function should be the only publically available class in this extension.
    // This can be called refreshUI if your app removes and adds content periodically.
    func setupUI() {
        switch type {
        case .get, .price, .refund:
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

            let color: UIColor = Styleguide.colors.white
            let copy: String
            switch self.type {
            case .get:
                copy = currentContent.purchaseButton.get
                break
            case .refund:
                copy = currentContent.purchaseButton.refund
                break
            case .price:
                if let product = self.product {
                    copy = product.displayPrice
                } else {
                    copy = currentContent.purchaseButton.missing
                }
                break
            default:
                copy = currentContent.purchaseButton.error
                break
            }

            self.label.attributedText = Styleguide.attributedProductButtonText(text: copy, color: Styleguide.colors.white)
        }
    }

    private func setupImageView(image: String, color: UIColor, width: CGFloat, height: CGFloat) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.addSubview(self.imageView)
            self.imageView.centerInSuperview()
            self.imageView.image = UIImage(named: image)?.withRenderingMode(.alwaysTemplate)
            self.imageView.tintColor = color
            self.imageView.width(width)
            self.imageView.height(height)
        }
    }
}
