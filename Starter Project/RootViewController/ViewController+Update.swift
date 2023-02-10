//
//  ViewController+Update.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 7/19/22.
//

import Foundation
import UIKit

extension ViewController {
    func updateConstraints() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.customViewTopConstraint﻿?.constant = ViewController.safeAreaInsets.top
            self.customViewRightConstraint﻿?.constant = -ViewController.safeAreaInsets.right
            self.customViewBottomConstraint﻿?.constant = -ViewController.safeAreaInsets.bottom
            self.customViewLeftConstraint﻿?.constant = ViewController.safeAreaInsets.left
            // Update Layout Constraints
            self.customView.updateLayoutConstraints()

            self.view.layoutIfNeeded()
            debugPrint("\(ViewController.identifier) \(DebuggingIdentifiers.actionOrEventSucceded) Updated Constraints")

        }
    }
}
