//
//  Button+Animations.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 7/18/22.

import Foundation
import UIKit

extension Button {

    // MARK: Sample Touch Based Animation Functions
    // Use OnTouchdownAnimation to animate your view when a users touches began occurs.
    func onTouchdownAnimation() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.layer.removeAllAnimations()
            UIView.animate(withDuration: kAnimationTime) { [weak self] in
                guard let self = self else { return }
                self.backgroundColor = self.type == .primary ? Styleguide.colors.white : Styleguide.colors.black
                self.title.textColor = self.type == .primary ? Styleguide.colors.black : Styleguide.colors.white
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
                self.backgroundColor = self.type == .primary ? Styleguide.colors.black : Styleguide.colors.white
                self.title.textColor = self.type == .primary ? Styleguide.colors.white : Styleguide.colors.black
            }
        }
    }
}
