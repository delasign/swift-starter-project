//
//  UIScreen+GetCurrentScreenBounds.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 8/29/23.
//

import Foundation
import UIKit

func getCurrentScreenBounds() -> CGRect {
    if let bounds = UIScreen.current?.bounds {
        return bounds
    } else {
        return .zero
    }
}
