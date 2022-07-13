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
        self.setupLabel()
    }

    private func setupLabel() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            // Allow the label to use constraints
            self.label.translatesAutoresizingMaskIntoConstraints = false
            // Add to subview
            self.view.addSubview(self.label)
            // Center in view
            self.label.centerInSuperview()
        }
    }
}
