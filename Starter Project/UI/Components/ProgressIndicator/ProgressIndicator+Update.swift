//
//  ProgressIndicator+Update.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 10/31/23.
//

import Foundation
import UIKit

extension ProgressIndicator {
    func update(color: UIColor, circleFillColor: UIColor?, dimension: CGFloat, lineWidth: CGFloat) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.background.backgroundColor = color

            self.circle.lineWidth = lineWidth
            self.circle.strokeColor = color.cgColor
            self.circle.fillColor = circleFillColor?.cgColor

            self.dimension = dimension

            self.widthConstraint?.constant = dimension
            self.heightConstraint?.constant = dimension

            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
    }

    func reset() {
        
        self.isCurrentlyDrawingItselfForTheFirstTime = false
        
        // Show No Circle
        self.strokeStart = 0.0
        self.circle.strokeStart = 0.0
        self.strokeEnd = 0.0
        self.circle.strokeEnd = 0.0
        
        self.circle.fillColor = nil
        self.circle.removeAllAnimations()
        self.background.backgroundColor = Styleguide.getPrimaryColor()
        self.background.layer.removeAllAnimations()
    }
}
