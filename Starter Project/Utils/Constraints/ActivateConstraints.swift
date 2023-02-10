//
//  ActivateConstraints.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 2/10/23.
//

import Foundation
import UIKit
import TinyConstraints

func activateConstraints(constraints: [NSLayoutConstraint?]) {
    for constraint in constraints {
        if let constraint = constraint {
            [constraint].activate()
        }
    }
}
