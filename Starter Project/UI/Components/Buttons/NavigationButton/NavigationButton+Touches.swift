//
//  NavigationButton+Touches.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 9/13/23.
//

import Foundation
import UIKit

extension NavigationButton {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Code your custom touches began functionality
        onTouchDownAnimation()
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Code your custom touches moved functionality
        if let touchPosition = (touches.first?.location(in: self.superview)) {
            let touch = self.convert(touchPosition, to: self)
            if self.frame.contains(touch) {
                self.onTouchDownAnimation()
            } else {
                self.onReleaseAnimation()
            }
        } else {
            self.onReleaseAnimation()
        }

    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.onReleaseAnimation()
        // Code your custom touches ended functionality
        if let touchPosition = (touches.first?.location(in: self.superview)) {
            let touch = self.convert(touchPosition, to: self)
            if self.frame.contains(touch) {
                self.onRelease?()
            }
        }
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Code your custom touches cancelled functionality
        self.onReleaseAnimation()
    }
}
