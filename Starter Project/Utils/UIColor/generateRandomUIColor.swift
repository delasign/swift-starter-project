//
//  generateRandomUIColor.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 10/24/23.
//

import Foundation
import UIKit

func generateRandomUIColor() -> UIColor {
    return UIColor(
        red: CGFloat.random(in: 0.0...1.0),
        green: CGFloat.random(in: 0.0...1.0),
        blue: CGFloat.random(in: 0.0...1.0),
        alpha: 1
    )
}
