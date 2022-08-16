//
//  CustomUIView+UI.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 7/18/22.
//

import Foundation
import UIKit
import TinyConstraints

extension CustomUIView {
    // The setupUI function should be the only publically available class in this extension.
    // This can be called refreshUI if your app removes and adds content periodically.
    func setupUI() {
        setupCarousel()
    }

    // MARK: UI Setup Functionality
    private func setupCarousel() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            // Add the View
            self.addSubview(self.carousel)
            // Setup the constraints
            self.carousel.top(to: self, offset: 100)
            self.carousel.left(to: self)
            self.carousel.right(to: self)
            self.carousel.height(300)
            // Register the cell
            self.carousel.register(CarouselCell.self, forCellWithReuseIdentifier: CarouselCell.identifier)
            // Set the delegate & datasource
            self.carousel.delegate = self
            self.carousel.dataSource = self
        }
    }
}
