//
//  OfferCodesAndRefundsCell+UI.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 3/16/23.
//

import Foundation
import UIKit

extension OfferCodesAndRefundsCell {
    func setupUI() {
        self.setupRedeemOfferCode()
        self.setupRequestRefund()
    }

    // MARK: UI Setup Functionality
    private func setupRedeemOfferCode() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.contentView.addSubview(self.redeemOfferCodeButton)
            self.redeemOfferCodeButton.top(to: self.contentView, offset: kPadding)
            self.redeemOfferCodeButton.left(to: self.contentView, offset: kPadding)
            self.redeemOfferCodeButton.right(to: self.contentView, offset: -kPadding)
        }
    }

    private func setupRequestRefund() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.contentView.addSubview(self.requestRefundButton)
            self.requestRefundButton.topToBottom(of: self.redeemOfferCodeButton, offset: kPadding)
            self.requestRefundButton.left(to: self.contentView, offset: kPadding)
            self.requestRefundButton.right(to: self.contentView, offset: -kPadding)
            self.requestRefundButton.bottom(to: self.contentView, offset: -kPadding, priority: UILayoutPriority(999))
        }
    }
}
