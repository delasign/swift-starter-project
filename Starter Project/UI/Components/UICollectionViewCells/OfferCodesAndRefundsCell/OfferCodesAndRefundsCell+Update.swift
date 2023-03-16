//
//  OfferCodesAndRefundsCell+Update.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 3/16/23.
//

import Foundation
import UIKit

extension OfferCodesAndRefundsCell {
    func update() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self, let currentContent = LanguageCoordinator.shared.currentContent else { return }
            // Redeem Offer Code
            self.redeemOfferCodeButton.title.attributedText = Styleguide.attributedProductButtonText(text: currentContent.offering.redeemOfferCode, color: Styleguide.colors.white)
            self.redeemOfferCodeButton.onRelease = { [weak self] in
                guard let self = self else { return }
                self.onRedeemOfferCode?()
            }
            // Request Refund
            self.requestRefundButton.title.attributedText = Styleguide.attributedProductButtonText(text: currentContent.shared.requestARefund, color: Styleguide.colors.black)
            self.requestRefundButton.onRelease = { [weak self] in
                guard let self = self else { return }
                self.onRequestARefund?()
            }
        }
    }
}
