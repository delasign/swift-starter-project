//
//  CustomButton+Touches.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 9/7/22.
//

import Foundation
import UIKit

extension CustomButton {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Animate to active state (black background, white text)
        self.animateToActiveState()
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Handle the touch
        self.handleTouch(touches, touchEnded: false)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Handle the touch
        self.handleTouch(touches, touchEnded: true)
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Animate to default state (white background, black text).
        self.animateToDefaultState()
    }

    // MARK: Handle Touch Functionality

    private func handleTouch(_ touches: Set<UITouch>, touchEnded: Bool) {
        /*
         Please note that we gather the position within the superview and translate it to the current view
         to guarantee that this works regardless of how nested the touch is within the view hierarchy.
         */

        // Gather the touch location in the superview
        if  let touchLocationInSuperview: CGPoint = touches.first?.location(in: self.superview) {
            // Gather the touch position within the custom button
            let touchLocation: CGPoint = self.convert(touchLocationInSuperview, to: self)
            /*
             // If Touches HAS NOT ended.
             If the touch location sits within the button, and its not animated to active (black background, white text),
             animate to the active state, if not animate to default state (white background, black text).
             // If Touches HAS ended.
             If the touch location sits within the button, execute onRelease. Else, do not.
             Then, Animate to default state (white background, black text).
             */
            if self.frame.contains(touchLocation) {
                // If the touch ended, send the onRelease Callback.
                if touchEnded {
                    // Animate to default state (white background, black text).
                    self.animateToDefaultState()
                    // Call on release
                    self.onRelease?()
                } else {
                    // Animate to active state (black background, white text)
                    self.animateToActiveState()
                }

            } else {
                // Animate to default state (white background, black text).
                self.animateToDefaultState()
            }

        } else {
            // Animate to default state (white background, black text).
            self.animateToDefaultState()
        }
    }
}
