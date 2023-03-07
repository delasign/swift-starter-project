//
//  ViewController+UI.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 7/13/22.
//

import Foundation
import UIKit
import TinyConstraints

extension ViewController {
    func setupUI() {
        debugPrint("\(ViewController.identifier) \(DebuggingIdentifiers.actionOrEventInProgress) Setting Up UI.")
        self.setupCustomUIView()
        debugPrint("\(ViewController.identifier) \(DebuggingIdentifiers.actionOrEventSucceded) Setup UI.")
    }

    private func setupCustomUIView() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            // Add to subview
            self.view.addSubview(self.landing)
            // Edges to Superview, with Safe Area Insets
            self.landingTopConstraint﻿ = self.landing.top(to: self.view, offset: ViewController.safeAreaInsets.top)
            self.landingRightConstraint﻿ = self.landing.right(to: self.view, offset: -ViewController.safeAreaInsets.right)
            self.landingBottomConstraint﻿ = self.landing.bottom(to: self.view, offset: -ViewController.safeAreaInsets.bottom)
            self.landingLeftConstraint﻿ = self.landing.left(to: self.view, offset: ViewController.safeAreaInsets.left)
            debugPrint("\(ViewController.identifier) \(DebuggingIdentifiers.actionOrEventSucceded) Setup landing!")
        }
    }
}
