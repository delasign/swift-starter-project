//
//  ProductTile.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 3/8/23.
//

import Foundation
import UIKit
import StoreKit

class ProductTile: UICollectionViewCell {
    // MARK: Variables
    static var identifier: String = "ProductTile"
    var type: ProductTileType = .get
    // MARK: UI
    let productTitle: UILabel = Styleguide.createAttributedProductTitle()
    let productDescription: UILabel = Styleguide.createAttributedProductDescription()
    let purchaseButton: PurchaseButton = PurchaseButton()

    let productDetail: UILabel = Styleguide.createAttributedProductDetail()
    var productDetailTopToBottomConstraint: NSLayoutConstraint?

    let actionButton: Button = Button(type: .primary)
    var actionButtonTopToBottomConstraint: NSLayoutConstraint?

    var product: Product?

    // MARK: Lifecycle
    // This is the function that gets called when you initialize your view.
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
        self.backgroundColor = Styleguide.colors.white
        self.layer.cornerRadius = kPadding
        self.layer.masksToBounds = false
    }

    func configure(type: ProductTileType, product: Product?) {
        self.type = type
        if let product = product {
            self.product = product
        }

        self.update()
    }

    override func layoutSubviews() {
        // Shadow
        self.layer.cornerRadius = kPadding
        self.layer.shadowOpacity = 1
        self.layer.shadowColor = Styleguide.colors.black.cgColor
        self.layer.shadowPath = UIBezierPath(
            roundedRect: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height),
            cornerRadius: kPadding).cgPath
        self.layer.shadowOffset = CGSize(width: 0, height: 5)
        self.layer.shadowOpacity = 0.5
    }

    // This function is required for a custom UIView.
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // This is the function that gets called when your UICollectionViewCell gets reused.
    // This is where you should remove any views that aren't constant, as well as deallocate data, images or text.
    override func prepareForReuse() {
        super.prepareForReuse()
        self.productTitle.text = ""
        self.productDescription.text = ""
        self.productDetail.text = ""
        self.actionButton.title.text = ""
        self.actionButton.onRelease = nil
        self.purchaseButton.onRelease = nil
        self.product = nil
    }
}
