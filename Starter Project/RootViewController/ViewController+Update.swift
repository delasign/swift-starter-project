//
//  ViewController+Update.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 7/19/22.
//

import Foundation
import UIKit

extension ViewController {
    // MARK: Constraints
    func updateConstraints() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            // Create an update functionality similar to that below for all the views that use the safe area constraints.
            // Layout Subviews
            self.view.layoutIfNeeded()
            debugPrint("\(ViewController.identifier) \(DebuggingIdentifiers.actionOrEventSucceded) Updated Constraints")

        }
    }

    // MARK: Experience States
    func onStateUpdate() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            // Hide and Show Relevant Screens
//            self.customView.isHidden = self.experienceState != .custom
            // Other Relevant Functionality...
        }
    }
}
