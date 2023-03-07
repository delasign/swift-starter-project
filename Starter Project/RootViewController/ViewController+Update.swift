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
            updateSafeAreaInsets(topConstraint: self.landingTopConstraint﻿, rightConstraint: self.landingRightConstraint﻿, bottomConstraint: self.landingBottomConstraint﻿, leftConstraint: self.landingLeftConstraint﻿)
            self.view.layoutIfNeeded()
            debugPrint("\(ViewController.identifier) \(DebuggingIdentifiers.actionOrEventSucceded) Updated Constraints")

        }
    }
}
