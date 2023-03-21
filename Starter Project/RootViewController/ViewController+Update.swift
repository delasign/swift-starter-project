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
            /// Landing
            updateSafeAreaInsets(topConstraint: self.landingTopConstraint﻿, rightConstraint: self.landingRightConstraint﻿, bottomConstraint: self.landingBottomConstraint﻿, leftConstraint: self.landingLeftConstraint﻿)
            /// Offering
            updateSafeAreaInsets(topConstraint: self.offeringTopConstraint﻿, rightConstraint: self.offeringRightConstraint﻿, bottomConstraint: self.offeringBottomConstraint﻿, leftConstraint: self.offeringLeftConstraint﻿)
            /// Refund
            updateSafeAreaInsets(topConstraint: self.refundTopConstraint﻿, rightConstraint: self.refundRightConstraint﻿, bottomConstraint: self.refundBottomConstraint﻿, leftConstraint: self.refundLeftConstraint﻿)
            /// Navigation Header
            updateSafeAreaInsets(topConstraint: self.navigationHeaderTopConstraint﻿, rightConstraint: self.navigationHeaderRightConstraint﻿, bottomConstraint: nil, leftConstraint: self.navigationHeaderLeftConstraint﻿)
            // storeKitProductNotification
            self.storeKitProductNotificationTopConstraint﻿?.constant = ViewController.safeAreaInsets.top
            // Update Layout
            self.view.layoutIfNeeded()
            debugPrint("\(ViewController.identifier) updateConstraints \(DebuggingIdentifiers.actionOrEventSucceded) Updated Constraints")
        }
    }

    func onStateUpdate() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            debugPrint("\(ViewController.identifier) \(DebuggingIdentifiers.actionOrEventInProgress) onStateUpdate \(DebuggingIdentifiers.actionOrEventInProgress) Updating screen layout to experience state : \(ViewController.experienceState)...")
            switch ViewController.experienceState {
            case .landing:
                self.landing.isHidden = false
                self.offering.isHidden = true
                self.refund.isHidden = true
                self.navigationHeader.isHidden = true
                break
            case .offering:
                self.landing.isHidden = true
                self.offering.isHidden = false
                self.refund.isHidden = true
                self.navigationHeader.isHidden = false
                break
            case .refund:
                self.landing.isHidden = true
                self.offering.isHidden = true
                self.refund.isHidden = false
                self.navigationHeader.isHidden = false
                break
            }
            debugPrint("\(ViewController.identifier) onStateUpdate \(DebuggingIdentifiers.actionOrEventSucceded) Updated screen layout to experience state : \(ViewController.experienceState).")
        }

    }
}
