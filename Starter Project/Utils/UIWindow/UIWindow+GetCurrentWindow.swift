//
//  UIWindow+GetCurrentWindow.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 8/29/23.
//

import Foundation
import UIKit

extension UIWindow {
    static var current: UIWindow? {
        for scene in UIApplication.shared.connectedScenes {
            guard let windowScene = scene as? UIWindowScene else { continue }
            for window in windowScene.windows {
                if window.isKeyWindow { return window }
            }
        }
        return nil
    }
}
