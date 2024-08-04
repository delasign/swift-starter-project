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
        self.setupARCameraView()
        debugPrint("\(ViewController.identifier) \(DebuggingIdentifiers.actionOrEventSucceded) Setup UI.")
    }

    private func setupARCameraView() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            // Add to subview
            self.view.addSubview(self.arCameraView)
            // Edges to Superview, with Safe Area Insets
            self.arViewTopConstraint﻿ = self.arCameraView.top(to: self.view, offset: ViewController.safeAreaInsets.top)
            self.arViewRightConstraint﻿ = self.arCameraView.right(to: self.view, offset: -ViewController.safeAreaInsets.right)
            self.arViewBottomConstraint﻿ = self.arCameraView.bottom(to: self.view, offset: -ViewController.safeAreaInsets.bottom)
            self.arViewLeftConstraint﻿ = self.arCameraView.left(to: self.view, offset: ViewController.safeAreaInsets.left)
            debugPrint("\(ViewController.identifier) \(DebuggingIdentifiers.actionOrEventSucceded) Setup ARCamera View!")
        }
    }
}
