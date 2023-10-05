//
//  Styleguide+SearchStyle.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 10/5/23.
//

import Foundation
import UIKit

extension Styleguide {
    static func createSearchStyle(
        text: String? = nil,
        color: UIColor? = nil
    ) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        if let text = text {
            label.attributedText = self.attributedSearchStyleText(text: text, color: color ?? Styleguide.getPrimaryColor())
        }
        label.textAlignment = .left
        label.sizeToFit()
        return label
    }

    static func attributedSearchStyleText(text: String, color: UIColor) -> NSMutableAttributedString {
        // Attributed Text
        return NSMutableAttributedString(string: text, attributes: searchStyleAttributes(color: color))
    }

    static func searchStyleAttributes(color: UIColor) -> [NSAttributedString.Key: Any] {
        // Paragraph Style
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        paragraphStyle.lineSpacing = 1
        return [
            NSAttributedString.Key.foregroundColor: color,
            NSAttributedString.Key.font: UIFont(name: fonts.HelveticaNeue, size: 24) ?? "",
            NSAttributedString.Key.paragraphStyle: paragraphStyle
        ]
    }
}
