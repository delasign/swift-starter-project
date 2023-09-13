//
//  StandardButton+UI.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 9/13/23.
//

import Foundation
import UIKit

extension StandardButton {
    func setupUI() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.setupLabel()
        }
    }

    private func setupLabel() {
        addSubview(label)
        label.centerInSuperview()
    }
}
