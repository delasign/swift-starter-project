//
//  CustomButton+UI.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 9/7/22.
//

import Foundation
import UIKit

extension CustomButton {
    func setupUI() {
        self.setupLabel()
    }

    // MARK: UI Setup Functionality
    private func setupLabel() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            // Add the label to the view
            self.addSubview(self.label)
            // Add the constraints
            self.label.centerInSuperview()
        }
    }
}
