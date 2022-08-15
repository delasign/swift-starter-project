//
//  CarouselCell+UI.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 8/15/22.
//

import Foundation
import UIKit
import TinyConstraints

extension CarouselCell {
    // The setupUI function should be the only publically available class in this extension.
    // This can be called refreshUI if your app removes and adds content periodically.
    func setupUI() {
        setupImageView()
    }

    // MARK: UI Setup Functionality
    private func setupImageView() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.imageView.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(self.imageView)
            self.imageView.edgesToSuperview()
        }
    }

}
