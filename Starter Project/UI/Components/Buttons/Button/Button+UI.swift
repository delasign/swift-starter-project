//
//  Button+UI.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 3/7/23.
//

import Foundation
import UIKit

extension Button {
    func setupUI() {
        setupTitle()
    }

    // MARK: UI Setup Functionality
    private func setupTitle() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.addSubview(self.title)
            self.title.centerInSuperview()
        }
    }
}
