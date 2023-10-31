//
//  ProgressIndicator+UI.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 10/31/23.
//

import Foundation
import UIKit

extension ProgressIndicator {
    func setupUI() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.setupBackground()
            self.setupMask()
        }
    }

    private func setupBackground() {
        background.translatesAutoresizingMaskIntoConstraints = false
        addSubview(background)
        background.top(to: self)
        background.edgesToSuperview()
    }

    func setupMask() {
        circle.strokeColor = Styleguide.getPrimaryColor().cgColor
        circle.lineWidth = lineWidth
        circle.fillColor = nil
        
        circle.strokeStart = 0.0
        circle.strokeEnd = 0.0

        gradientMask.translatesAutoresizingMaskIntoConstraints = false
        gradientMask.backgroundColor = .clear
        gradientMask.layer.masksToBounds = false
        gradientMask.layer.addSublayer(self.circle)
        background.mask = self.gradientMask
    }
}
