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
        setupScrollIndicator()
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

    private func setupScrollIndicator() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            // Allow Constraints
            self.scrollIndicator.translatesAutoresizingMaskIntoConstraints = false
            // Add stackview to UIView
            self.addSubview(self.scrollIndicator)
            // Place the stackview centered, below the carousel offset by the padding constant.
            self.scrollIndicator.centerX(to: self)
            self.scrollIndicator.topToBottom(of: self.carousel, offset: kPadding)
            // Set the scroll indicator view offset
            self.scrollIndicator.spacing = 8
            /*
             Add the indicators
             Please note we use 4 as it is the number of cards available - 1, as 0 counts.
             This number (5) is declared in the +CollectionView extension on line 26.
             */
            for indicatorIndex in 0...4 {
                // Create a new indicator
                let indicator: CarouselIndicator = CarouselIndicator()
                // Set the alpha to 1 if its the current index, else 0.4
                indicator.alpha = self.currentIndex == indicatorIndex ? 1 : 0.4
                // Add it to the stackview
                self.scrollIndicator.addArrangedSubview(indicator)
                // Set the indicator size
                indicator.width(8)
                indicator.height(8)
                // Set the corner radius to half of the size
                indicator.layer.cornerRadius = 4
                // Add it to the indicator array
                self.indicators.append(indicator)
                // Setup the callback
                indicator.onRelease = { [weak self] in
                    guard let self = self else { return }
                    self.snapToPositon(index: indicatorIndex)
                }
            }
        }
    }
}
