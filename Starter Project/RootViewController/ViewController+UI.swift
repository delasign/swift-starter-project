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
        self.setupMetalView()
        debugPrint("\(ViewController.identifier) \(DebuggingIdentifiers.actionOrEventSucceded) Setup UI.")
    }

//    private func setupCustomUIView() {
//        DispatchQueue.main.async { [weak self] in
//            guard let self = self else { return }
//            // Add to subview
//            self.view.addSubview(self.customView)
//            // Edges to Superview, with Safe Area Insets
//            self.customViewTopConstraint﻿ = self.customView.top(to: self.view, offset: ViewController.safeAreaInsets.top)
//            self.customViewRightConstraint﻿ = self.customView.right(to: self.view, offset: -ViewController.safeAreaInsets.right)
//            self.customViewBottomConstraint﻿ = self.customView.bottom(to: self.view, offset: -ViewController.safeAreaInsets.bottom)
//            self.customViewLeftConstraint﻿ = self.customView.left(to: self.view, offset: ViewController.safeAreaInsets.left)
//            debugPrint("\(ViewController.identifier) \(DebuggingIdentifiers.actionOrEventSucceded) Setup Custom View!")
//        }
//    }
//    
    private func setupMetalView() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            // Add to subview
            self.view.addSubview(self.metalView)
            // Edges to Superview, with Safe Area Insets
            self.metalViewTopConstraint﻿ = self.metalView.top(to: self.view, offset: ViewController.safeAreaInsets.top)
            self.metalViewRightConstraint﻿ = self.metalView.right(to: self.view, offset: -ViewController.safeAreaInsets.right)
            self.metalViewBottomConstraint﻿ = self.metalView.bottom(to: self.view, offset: -ViewController.safeAreaInsets.bottom)
            self.metalViewLeftConstraint﻿ = self.metalView.left(to: self.view, offset: ViewController.safeAreaInsets.left)
            debugPrint("\(ViewController.identifier) \(DebuggingIdentifiers.actionOrEventSucceded) Setup Metal View!")
        }
    }
}
