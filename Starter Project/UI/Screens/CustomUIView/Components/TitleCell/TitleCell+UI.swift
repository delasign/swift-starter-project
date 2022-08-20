//
//  TitleCell+UI.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 8/20/22.
//

import Foundation
import UIKit

extension TitleCell {
    func setupUI() {
        setupLabel()
    }

    private func setupLabel() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.addSubview(self.label)
            self.label.centerY(to: self)
            self.label.left(to: self)
        }
    }
}
