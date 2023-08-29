//
//  UIView+GetBoundsWithoutSafeInsets.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 8/29/23.
//

import Foundation
import UIKit

extension UIView {
    func getBoundsWithoutSafeAreaInsets() -> CGRect {
        let bounds = getCurrentScreenBounds()
        let safeAreaInsets = ViewController.safeAreaInsets
        return CGRect(
            x: 0,
            y: 0,
            width: bounds.width - safeAreaInsets.left - safeAreaInsets.right,
            height: bounds.height - safeAreaInsets.top - safeAreaInsets.bottom
        )
    }
}
