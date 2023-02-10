//
//  DeactivateConstraints.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 2/10/23.
//

import Foundation
import UIKit
import TinyConstraints

func deactivateConstraints(constraints: [NSLayoutConstraint?]) {
    for constraint in constraints {
        if let constraint = constraint {
            [constraint].deActivate()
        }
    }
}
