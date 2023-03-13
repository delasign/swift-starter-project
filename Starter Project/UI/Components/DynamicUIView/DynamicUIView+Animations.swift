//
//  DynamicUIView+Animations.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 3/13/23.
//

import Foundation
import UIKit

extension DynamicUIView {
    func animateToDefaultState() {
        if self.backgroundColor != Styleguide.colors.black {
            // Animate to default state (black background, white text).
            self.animateTo(backgroundColor: Styleguide.colors.black, textColor: Styleguide.colors.white)
        }
    }

    func animateToActiveState() {
        if self.backgroundColor != Styleguide.colors.white {
            // Animate to default state (white background, black text).
            self.animateTo(backgroundColor: Styleguide.colors.white, textColor: Styleguide.colors.black)
        }
    }

    private func animateTo(backgroundColor: UIColor, textColor: UIColor) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            UIView.animate(withDuration: kAnimationTime) {
                self.backgroundColor = backgroundColor
                self.label.textColor = textColor
            }
        }
    }
}
