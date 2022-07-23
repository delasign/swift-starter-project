//
//  Styleguide+HeadlineStyle.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 7/23/22.
//

import Foundation
import UIKit

extension Styleguide {
    static func createHeadlineStyle(
        text: String? = nil
    ) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        if let text = text {
            label.attributedText = self.attributedHeadlineText(text: text)
        }
        label.textAlignment = .left
        label.sizeToFit()
        return label
    }

    static func attributedHeadlineText(text: String) -> NSMutableAttributedString {
        // Paragraph Style
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.lineSpacing = 1
        // Attributed Text
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: Styleguide.colors.black,
            NSAttributedString.Key.font: UIFont(name: fonts.HelveticaNeueBold, size: 24) ?? "",
            NSAttributedString.Key.paragraphStyle: paragraphStyle
        ]
        return NSMutableAttributedString(string: text, attributes: attributes)
    }
}
