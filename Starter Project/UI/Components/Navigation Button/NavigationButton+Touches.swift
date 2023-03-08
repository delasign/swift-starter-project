//
//  NavigationButton+Touches.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 3/8/23.
//

import Foundation
import UIKit

extension NavigationButton {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Code your custom touches began functionality
        onTouchdownAnimation()
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Code your custom touches moved functionality
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Code your custom touches ended functionality
        onReleaseAnimation()
        onRelease?()
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Code your custom touches cancelled functionality
        onReleaseAnimation()
    }
}
