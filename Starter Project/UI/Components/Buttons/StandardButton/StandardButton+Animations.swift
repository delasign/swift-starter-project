//
//  StandardButton+Animations.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 9/13/23.
//

import Foundation
import UIKit

extension StandardButton {
    func onTouchDownAnimation() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            UIView.animate(withDuration: kAnimationTime) {
                self.backgroundColor = Styleguide.getPrimaryColor()
                self.label.textColor = Styleguide.getBackgroundColor()
            }
        }
    }

    func onReleaseAnimation() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            UIView.animate(withDuration: kAnimationTime) {
                self.backgroundColor = Styleguide.getBackgroundColor()
                self.label.textColor = Styleguide.getPrimaryColor()
            }
        }
    }
}
