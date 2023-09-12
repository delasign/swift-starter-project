//
//  UIContent.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 7/13/22.
//

import Foundation
import UIKit

struct UIContent: Codable {
    struct Exercise: Codable {
        let header: String
    }

    let exercise: Exercise
}
