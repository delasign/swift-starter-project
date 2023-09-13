//
//  NavigationButton+Animations.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 9/13/23.
//

import Foundation
import UIKit

extension NavigationButton {
    func onTouchDownAnimation() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            UIView.animate(withDuration: kAnimationTime) {
                self.backgroundColor = Styleguide.getPrimaryColor()
                self.imageView.tintColor = Styleguide.getBackgroundColor()
            }
        }
    }

    func onReleaseAnimation() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.imageView.tintColor = Styleguide.getBackgroundColor()
            UIView.animate(withDuration: kAnimationTime) {
                self.backgroundColor = Styleguide.getBackgroundColor()
                self.imageView.tintColor = Styleguide.getPrimaryColor()
            }
        }
    }
}
