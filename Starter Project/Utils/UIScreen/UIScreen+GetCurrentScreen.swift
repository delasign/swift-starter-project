//
//  UIScreen+GetCurrentScreen.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 8/29/23.
//

import Foundation
import UIKit

extension UIScreen {
    static var current: UIScreen? {
        UIWindow.current?.screen
    }
}
