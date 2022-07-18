//
//  CustomUIView+Animations.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 7/18/22.
//

import Foundation
import UIKit

extension CustomUIView {

    // MARK: Sample Touch Based Animation Functions
    // Use OnTouchdownAnimation to animate your view when a users touches began occurs.
    func onTouchdownAnimation() {
        DispatchQueue.main.async { [weak self] in
            guard let _ = self else { return }
        }
    }

    // Use onReleaseAnimation to aniamte your view when a users touch ends.
    func onReleaseAnimation() {
        DispatchQueue.main.async { [weak self] in
            guard let _ = self else { return }
        }
    }

    // MARK: Sample Animation LifeCycle
    // Call onAnimateIn to carry out the animation that happens when it comes into the screen.
    func onAnimateIn() {

    }

    // Call onAnimateOut to carry out the animation that happens when it comes out of a screen.
    func onAnimateOut() {

    }
}
