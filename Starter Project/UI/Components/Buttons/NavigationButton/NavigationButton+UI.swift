//
//  NavigationButton+UI.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 9/13/23.
//

import Foundation
import UIKit

extension NavigationButton {
    func setupUI() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.setupImageView()
        }
    }

    private func setupImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        imageView.centerInSuperview()
        imageView.width(kButtonDimension - kPadding)
        imageView.height(kButtonDimension - kPadding)
        imageView.tintColor = Styleguide.getPrimaryColor()
    }
}
