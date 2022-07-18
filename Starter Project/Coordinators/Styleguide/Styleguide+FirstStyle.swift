//
//  Styleguide+FirstStyle.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 7/13/22.
//

import Foundation
import UIKit

extension Styleguide {

    static func createFirstStyleLabel() -> UILabel {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = colors.white
        label.font = UIFont(name: fonts.HelveticaNeue, size: 40)
        return label
    }
}
