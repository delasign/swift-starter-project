//
//  RestorePurchasesCell+Update.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 3/16/23.
//

import Foundation
import UIKit

extension RestorePurchasesCell {
    func update() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self, let currentContent = LanguageCoordinator.shared.currentContent else { return }
            // Button
            self.button.title.attributedText = Styleguide.attributedLabelText(text: currentContent.offering.restorePurchases, color: Styleguide.colors.white)
            self.button.onRelease = { [weak self] in
                guard let self = self else { return }
                self.onRelease?()
            }
        }
    }
}
