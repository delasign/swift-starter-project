//
//  Styleguide+ProductDetail.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 3/16/23.
//

import Foundation
import UIKit

extension Styleguide {
    static func createAttributedProductDetail(
        text: String? = nil
    ) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        if let text = text {
            label.attributedText = self.attributedProductDescriptionText(text: text)
        }
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }

    static func attributedProductDetailText(text: String, color: UIColor? = Styleguide.colors.black) -> NSMutableAttributedString {
        guard let color = color else { return NSMutableAttributedString(string: "ERROR") }
        // Paragraph Style
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        paragraphStyle.lineSpacing = 1
        // Attributed Text
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: color,
            NSAttributedString.Key.font: UIFont(name: fonts.HelveticaNeueBold, size: 18) ?? "",
            NSAttributedString.Key.paragraphStyle: paragraphStyle
        ]
        return NSMutableAttributedString(string: text, attributes: attributes)
    }
}
