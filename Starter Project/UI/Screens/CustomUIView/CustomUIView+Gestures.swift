//
//  CustomUIView+Gestures.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 7/18/22.
//

import Foundation
import UIKit

extension CustomUIView {
    // The setupGestures function should be the only publically available class in this extension.
    func setupGestures() {
        self.setupTapGesture()
    }

    // MARK: Gestures Setup Functionality

    private func setupTapGesture() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.onTap(sender:)))
            self.addGestureRecognizer(tap)

        }
    }

    @objc private func onTap(sender: UITapGestureRecognizer) {
        debugPrint("\(ViewController.identifier) \(DebuggingIdentifiers.actionOrEventSucceded) Tapped CustomView")
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            // Declare the new constant to be 100, if the current one is 0 and 0 if otherwise.
            let newConstant: CGFloat = self.labelCenterConstraint?.constant == 0 ? 100 : 0
            // Remove all animations
            self.layer.removeAllAnimations()
            // Set new constraint
            self.labelCenterConstraint?.constant = newConstant
            // Set Needs Layout
            self.setNeedsLayout()
            // Animate the label
            UIView.animate(withDuration: 0.5) {
                self.layoutIfNeeded()
            }
        }
    }
}
