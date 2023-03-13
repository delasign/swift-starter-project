//
//  DynamicUIView+UI.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 3/13/23.
//

import Foundation
import UIKit
import TinyConstraints

extension DynamicUIView {
    // The setupUI function should be the only publically available class in this extension.
    // This can be called refreshUI if your app removes and adds content periodically.
    func setupUI() {
        self.setupLabel()
    }

    // MARK: UI Setup Functionality
    private func setupLabel() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.addSubview(self.label)
            self.label.centerInSuperview()
            self.label.preferredMaxLayoutWidth = 150
        }
    }
}
