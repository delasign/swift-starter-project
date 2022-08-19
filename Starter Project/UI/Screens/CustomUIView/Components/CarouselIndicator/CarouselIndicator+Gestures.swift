//
//  CarouselIndicator+Gestures.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 8/19/22.
//

import Foundation
import UIKit

extension CarouselIndicator {
    // The setupGestures function should be the only publically available class in this extension.
    func setupGestures() {
        self.setupTapGesture()
    }

    // MARK: Gestures Setup Functionality
    // All functions that appear below this should be private for example:

    private func setupTapGesture() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.onTap(sender:)))
            self.addGestureRecognizer(tap)
        }
    }

    @objc private func onTap(sender: UITapGestureRecognizer) {
        switch sender.state {
        case .ended:
            self.onRelease?()
            break
        default:
            break
        }
    }
}
