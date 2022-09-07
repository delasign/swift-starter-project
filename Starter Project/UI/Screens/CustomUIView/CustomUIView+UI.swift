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
        self.setupButton()
    }

    // MARK: UI Setup Functionality
    private func setupButton() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            // Add the button to the view
            self.addSubview(self.button)
            // Add the constraints
            self.button.centerInSuperview()
            self.button.left(to: self, offset: kPadding)
            self.button.right(to: self, offset: -kPadding)
            self.button.height(60)
            // Add the callback with the log, to demonstrate an succeful onRelease
            self.button.onRelease = { [weak self] in
                guard let _ = self else { return }
                debugPrint("\(CustomButton.identifier) setupButton \(DebuggingIdentifiers.actionOrEventSucceded) user tapped the button!")
            }
        }
    }
}
