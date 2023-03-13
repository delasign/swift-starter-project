//
//  DynamicUIView+Update.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 3/13/23.
//

import Foundation
import UIKit

extension DynamicUIView {
    func update() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self, let currentContent = LanguageCoordinator.shared.currentContent else { return }

            // Determine the active copy
            let copy: String
            switch self.count {
            case 1:
                copy = currentContent.sample.sampleStringII
                break
            case 2:
                copy = currentContent.sample.sampleStringIII
                break
            default:
                copy = currentContent.sample.sampleString
                break
            }
            // Set the copy
            self.label.attributedText = Styleguide.attributedText(text: copy)
            self.label.sizeToFit()

            // Calculate the new size - please note that the 150px width is fixed due to the length of the copy
            let newWidth: CGFloat = 150 + 2 * kPadding
            let newHeight: CGFloat = self.label.frame.height + 2 * kPadding

            // Set the new cosntraints
            if let _ = self.widthConstraint {
                self.widthConstraint?.constant = newWidth
            } else {
                self.widthConstraint = self.width(newWidth)
            }

            if let _ = self.heighConstraint {
                self.heighConstraint?.constant = newHeight
            } else {
                self.heighConstraint = self.height(newHeight)
            }

            self.setNeedsLayout()

            // Animate the UIView to size and color
            UIView.animate(withDuration: kAnimationTime) { [weak self] in
                guard let self = self else { return }
                self.layoutIfNeeded()
                self.backgroundColor = Styleguide.colors.black
                self.label.textColor = Styleguide.colors.white
            }

        }
    }
}
