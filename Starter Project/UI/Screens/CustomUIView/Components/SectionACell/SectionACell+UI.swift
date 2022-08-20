//
//  SectionACell+UI.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 8/20/22.
//

import Foundation
import UIKit

extension SectionACell {
    func setupUI() {
        setupImageView()
    }
    
    private func setupImageView() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.imageView.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(self.label)
            self.label.centerY(to: self)
            self.label.left(to: self, offset: kPadding)
        }
    }
}

