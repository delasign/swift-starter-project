//
//  Styleguide+MetricStyle.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 10/5/23.
//

import Foundation
import UIKit

extension Styleguide {
    static func createMetricStyle(
        highlight: String? = nil,
        statistic: String? = nil
    ) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        if let highlight = highlight, let statistic = statistic {
            label.attributedText = self.attributedMetricStyleText(highlight: highlight, statistic: statistic)
        }
        label.textAlignment = .left
        label.sizeToFit()
        return label
    }

    static func attributedMetricStyleText(highlight: String, statistic: String) -> NSMutableAttributedString {
        // Paragraph Style
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        paragraphStyle.lineSpacing = 1
        // Regular Attributed
        let regularAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: Styleguide.getPrimaryColor(),
            NSAttributedString.Key.font: UIFont(name: fonts.HelveticaNeue, size: 14) ?? "",
            NSAttributedString.Key.paragraphStyle: paragraphStyle
        ]
        // Bold Attributes
        let boldAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: Styleguide.getPrimaryColor(),
            NSAttributedString.Key.font: UIFont(name: fonts.HelveticaNeueBold, size: 14) ?? "",
            NSAttributedString.Key.paragraphStyle: paragraphStyle
        ]

        // Create the string with the highlight (Bold)
        let string: NSMutableAttributedString = NSMutableAttributedString(string: highlight + ": ", attributes: boldAttributes)
        // Append the regular string
        string.append(NSMutableAttributedString(string: statistic, attributes: regularAttributes))
        // Return the string
        return string
    }
}
