//
//  Styleguide.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 7/13/22.
//

import Foundation
import UIKit

class Styleguide: NSObject {
    // MARK: Variables
    static let identifier: String = "[Styleguide]"
    static let colors: Colors = Colors()
    static let fonts: Fonts = Fonts()
    
    static let isDarkMode: Bool = {
        return UIScreen.main.traitCollection.userInterfaceStyle == .dark
    }()

    static func getBackgroundColor() -> UIColor {
        if #available(iOS 13.0, *) {
            return isDarkMode ? colors.black : colors.white
        } else {
            return colors.white
        }

    }

    static func getPrimaryColor() -> UIColor {
        if #available(iOS 13.0, *) {
            return isDarkMode ? colors.white : colors.black
        } else {
            return colors.black
        }
    }
}
