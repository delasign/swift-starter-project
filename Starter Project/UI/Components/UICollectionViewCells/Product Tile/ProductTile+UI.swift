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
            self.setupTransactionLabel()
            self.setupProductTitle()
            self.setupProductDescription()
            self.setupProductDetail()
            self.setupActionButton()
        }
    }

    // MARK: UI Setup Functionality
    private func setupTransactionLabel() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.contentView.addSubview(self.transactionLabel)
            self.transactionLabel.top(to: self.contentView, offset: kPadding)
            self.transactionLabel.right(to: self.contentView, offset: -kPadding)
        }
    }

    private func setupProductTitle() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.contentView.addSubview(self.productTitle)
            self.productTitle.top(to: self.contentView, offset: kPadding)
            self.productTitle.left(to: self.contentView, offset: kPadding)
            // Variable constraints
            self.productTitleRightToLeftOfButtonConstraint = self.productTitle.rightToLeft(of: self.transactionLabel, offset: -kPadding, isActive: true)
            self.productTitleRightToContentViewConstraint = self.productTitle.right(to: self.contentView, offset: -kPadding, isActive: false)
        }
    }

    private func setupProductDescription() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.contentView.addSubview(self.productDescription)
            self.productDescription.topToBottom(of: self.productTitle, offset: kPadding)
            self.productDescription.left(to: self.contentView, offset: kPadding)
            self.productDescription.right(to: self.contentView, offset: -kPadding)
            // The priority for the trailing anchor must be set to 999 to avoid any auto-layout breaks
            self.productDescriptionBottomToContentViewConstraint = self.productDescription.bottom(to: self.contentView, offset: -kPadding, priority: UILayoutPriority(999), isActive: true)
        }
    }

    private func setupProductDetail() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.contentView.addSubview(self.productDetail)
            // Initially inactive and hidden - this means the constraitns inactive.
            self.productDetail.topToBottom(of: self.productDescription, offset: kPadding)
            self.productDetail.left(to: self.contentView, offset: kPadding)
            self.productDetail.right(to: self.contentView, offset: -kPadding)
            // The priority for the trailing anchor must be set to 999 to avoid any auto-layout breaks
            self.productDetailBottomConstraint = self.productDetail.bottom(to: self.contentView, offset: -kPadding, priority: UILayoutPriority(999), isActive: false)
            self.productDetail.isHidden = true
        }
    }

    private func setupActionButton() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.contentView.addSubview(self.actionButton)
            // Initially inactive and hidden = therefore the offset is 0 and height is 0 and both constraints are inactive
            self.actionButtonTopToBottomOfProductDetailConstraint = self.actionButton.topToBottom(of: self.productDetail, offset: 0, isActive: false)
            self.actionButtonTopToBottomOfProductDescriptionConstraint = self.actionButton.topToBottom(of: self.productDescription, offset: kPadding, isActive: false)
            self.actionButtonLeftConstraint = self.actionButton.left(to: self.contentView, offset: kPadding, isActive: false)
            self.actionButtonRightConstraint = self.actionButton.right(to: self.contentView, offset: -kPadding, isActive: false)
            // The priority for the trailing anchor must be set to 999 to avoid any auto-layout breaks
            self.actionButtonBottomConstraint = self.actionButton.bottom(to: self.contentView, offset: -kPadding, priority: UILayoutPriority(999), isActive: false)
            self.actionButton.isHidden = true
        }
    }

}
