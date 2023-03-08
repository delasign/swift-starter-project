//
//  Styleguide+AttributedStyle.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 7/18/22.
//

import Foundation
import UIKit

extension Styleguide {
    static func createAttributedSectionTitle(
        text: String? = nil
    ) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        if let text = text {
            label.attributedText = self.attributedSectionTitleText(text: text)
        }
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }

    static func attributedSectionTitleText(text: String) -> NSMutableAttributedString {
        // Paragraph Style
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        paragraphStyle.lineSpacing = 1
        // Attributed Text
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: Styleguide.colors.black,
            NSAttributedString.Key.font: UIFont(name: fonts.HelveticaNeueBold, size: 36) ?? "",
            NSAttributedString.Key.paragraphStyle: paragraphStyle
        ]
        return NSMutableAttributedString(string: text, attributes: attributes)
    }
}
