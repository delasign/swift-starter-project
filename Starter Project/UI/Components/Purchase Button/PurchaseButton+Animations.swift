//
//  PurchaseButton+Update.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 3/8/23.
//

import Foundation
import UIKit

extension PurchaseButton {

    // MARK: Sample Touch Based Animation Functions
    // Use OnTouchdownAnimation to animate your view when a users touches began occurs.
    func onTouchdownAnimation() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.layer.removeAllAnimations()
            UIView.animate(withDuration: kAnimationTime) { [weak self] in
                guard let self = self else { return }
                self.backgroundColor = Styleguide.colors.white
                self.label.textColor = self.getBackgroundColor()
                self.imageView.tintColor = self.getBackgroundColor()
            }
        }
    }

    // Use onReleaseAnimation to aniamte your view when a users touch ends.
    func onReleaseAnimation() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.layer.removeAllAnimations()
            UIView.animate(withDuration: kAnimationTime) { [weak self] in
                guard let self = self else { return }
                self.backgroundColor = self.getBackgroundColor()
                self.label.textColor = Styleguide.colors.white
                self.label.tintColor = Styleguide.colors.white
            }
        }
    }
}
