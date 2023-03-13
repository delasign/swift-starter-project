//
//  Styleguide+CellBody.swift .swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 3/13/23.
//

import Foundation
import UIKit

extension Styleguide {
    static func createCellBodyStyle(
        text: String? = nil
    ) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        if let text = text {
            label.attributedText = self.attributedCellBodyText(text: text)
        }
        label.textAlignment = .left
        label.sizeToFit()
        return label
    }

    static func attributedCellBodyText(text: String) -> NSMutableAttributedString {
        // Paragraph Style
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        paragraphStyle.lineSpacing = 1
        // Attributed Text
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: Styleguide.colors.black,
            NSAttributedString.Key.font: UIFont(name: fonts.HelveticaNeue, size: 14) ?? "",
            NSAttributedString.Key.paragraphStyle: paragraphStyle
        ]
        return NSMutableAttributedString(string: text, attributes: attributes)
    }
}