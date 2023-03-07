//
//  Styleguide+ProductButton.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 3/7/23.
//

import Foundation
import UIKit

extension Styleguide {
    static func createAttributedProductButton(
        text: String? = nil
    ) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        if let text = text {
            // Colors default to black
            label.attributedText = self.attributedProductButtonText(text: text, color: Styleguide.colors.black)
        }
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }

    static func attributedProductButtonText(text: String, color: UIColor) -> NSMutableAttributedString {
        // Paragraph Style
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.lineSpacing = 1
        // Attributed Text
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: color,
            NSAttributedString.Key.font: UIFont(name: fonts.HelveticaNeueBold, size: 24) ?? "",
            NSAttributedString.Key.paragraphStyle: paragraphStyle
        ]
        return NSMutableAttributedString(string: text, attributes: attributes)
    }
}
