//
//  PrintSystemFonts.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 7/20/22.
//

import Foundation
import UIKit

public func printSystemFonts() {
    // Use this identifier to filter out the system fonts in the logs.
    let identifier: String = "[SYSTEM FONTS]"
    // Here's the functionality that prints all the system fonts.
    for family in UIFont.familyNames as [String] {
        debugPrint("\(identifier) FONT FAMILY :  \(family)")
        for name in UIFont.fontNames(forFamilyName: family) {
            debugPrint("\(identifier) FONT NAME :  \(name)")
        }
    }
}
