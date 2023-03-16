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
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.setupPurchaseButton()
            self.setupProductTitle()
            self.setupProductDescription()
            //            self.setupProductDetail()
            //            self.setupActionButton()
        }
    }

    // MARK: UI Setup Functionality
    private func setupPurchaseButton() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.contentView.addSubview(self.purchaseButton)
            self.purchaseButton.top(to: self.contentView, offset: kPadding)
            self.purchaseButton.right(to: self.contentView, offset: -kPadding)
        }
    }

    private func setupProductTitle() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.contentView.addSubview(self.productTitle)
            self.productTitle.top(to: self.contentView, offset: kPadding)
            self.productTitle.left(to: self.contentView, offset: kPadding)
            self.productTitle.rightToLeft(of: self.purchaseButton, offset: -kPadding)
            self.productTitle.height(min: kButtonDimension)
            self.productTitle.backgroundColor = .red
        }
    }

    private func setupProductDescription() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.contentView.addSubview(self.productDescription)
            self.productDescription.topToBottom(of: self.productTitle, offset: kPadding)
            self.productDescription.left(to: self.contentView, offset: kPadding)
            self.productDescription.right(to: self.contentView, offset: -kPadding)
            self.productDescription.bottom(to: self.contentView, offset: -kPadding)
            self.productDescription.backgroundColor = .red
        }
    }

    private func setupProductDetail() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.contentView.addSubview(self.productDetail)
            // Initially inactive - this suggest an offset of 0 and height is 0
            self.productDetailTopToBottomConstraint = self.productDetail.topToBottom(of: self.productDescription, offset: 0)
            self.productDetail.left(to: self.contentView, offset: kPadding)
            self.productDetail.right(to: self.contentView, offset: -kPadding)
            self.productDetail.backgroundColor = .red
        }
    }

    private func setupActionButton() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.contentView.addSubview(self.actionButton)
            // Initially inactive and hidden = therefore the offset is 0 and height is 0
            self.actionButtonTopToBottomConstraint = self.actionButton.topToBottom(of: self.productDetail, offset: 0)
            self.actionButton.left(to: self.contentView, offset: kPadding)
            self.actionButton.right(to: self.contentView, offset: -kPadding)
            self.actionButton.bottom(to: self.contentView, offset: -kPadding)
            self.actionButton.heightConstraint?.constant = 0
            //            self.actionButton.isHidden = true
        }
    }

}
