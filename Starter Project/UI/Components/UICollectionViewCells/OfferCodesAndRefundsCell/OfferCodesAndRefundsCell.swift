//
//  OfferCodesAndRefundsCell.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 3/16/23.
//

import Foundation
import UIKit

class OfferCodesAndRefundsCell: UICollectionViewCell {
    // MARK: Variables
    static var identifier: String = "OfferCodesAndRefundsCell"
    var type: ProductTileType = .get
    // MARK: UI
    let redeemOfferCodeButton: Button = Button(type: .primary)
    let requestRefundButton: Button = Button(type: .secondary)
    // MARK: Callbacks
    var onRedeemOfferCode: (() -> Void)?
    var onRequestARefund: (() -> Void)?

    // MARK: Lifecycle
    // This is the function that gets called when you initialize your view.
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
        self.backgroundColor = Styleguide.colors.white
    }

    // This function is required for a custom UIView.
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // This is the function that gets called when your UICollectionViewCell gets reused.
    // This is where you should remove any views that aren't constant, as well as deallocate data, images or text.
    override func prepareForReuse() {
        super.prepareForReuse()
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.redeemOfferCodeButton.title.text = ""
            self.requestRefundButton.title.text = ""
            self.redeemOfferCodeButton.onRelease = nil
            self.requestRefundButton.onRelease = nil
            self.onRequestARefund = nil
            self.onRedeemOfferCode = nil
        }
    }
}
