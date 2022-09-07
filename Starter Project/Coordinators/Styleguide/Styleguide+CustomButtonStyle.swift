//
//  Styleguide+CustomButtonStyle.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 9/7/22.
//

import Foundation
import UIKit

extension Styleguide {
    static func createCustomButtonStyle(
        text: String? = nil
    ) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        if let text = text {
            label.attributedText = self.attributedCustomButtonText(text: text)
        }
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }

    static func attributedCustomButtonText(text: String) -> NSMutableAttributedString {
        // Paragraph Style
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.lineSpacing = 1
        // Attributed Text
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: Styleguide.colors.black,
            NSAttributedString.Key.font: UIFont(name: fonts.HelveticaNeue, size: 24) ?? "",
            NSAttributedString.Key.paragraphStyle: paragraphStyle
        ]
        return NSMutableAttributedString(string: text, attributes: attributes)
    }
}
