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
        // Set the views up in inverse order
        self.setupRefund()
        self.setupOffering()
        self.setupLanding()
        // The header is at the top
        self.setupNavigationHeader()
        debugPrint("\(ViewController.identifier) \(DebuggingIdentifiers.actionOrEventSucceded) Setup UI.")
    }
    // MARK: UI Setup Functionality
    private func setupLanding() {
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

    private func setupOffering() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            // Add to subview
            self.view.addSubview(self.offering)
            // Edges to Superview, with Safe Area Insets
            self.offeringTopConstraint﻿ = self.offering.top(to: self.view, offset: ViewController.safeAreaInsets.top)
            self.offeringRightConstraint﻿ = self.offering.right(to: self.view, offset: -ViewController.safeAreaInsets.right)
            self.offeringBottomConstraint﻿ = self.offering.bottom(to: self.view, offset: -ViewController.safeAreaInsets.bottom)
            self.offeringLeftConstraint﻿ = self.offering.left(to: self.view, offset: ViewController.safeAreaInsets.left)
            // Offering is initially hidden
            self.offering.isHidden = true
            debugPrint("\(ViewController.identifier) \(DebuggingIdentifiers.actionOrEventSucceded) Setup Offering!")
        }
    }

    private func setupRefund() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            // Add to subview
            self.view.addSubview(self.refund)
            // Edges to Superview, with Safe Area Insets
            self.refundTopConstraint﻿ = self.refund.top(to: self.view, offset: ViewController.safeAreaInsets.top)
            self.refundRightConstraint﻿ = self.refund.right(to: self.view, offset: -ViewController.safeAreaInsets.right)
            self.refundBottomConstraint﻿ = self.refund.bottom(to: self.view, offset: -ViewController.safeAreaInsets.bottom)
            self.refundLeftConstraint﻿ = self.refund.left(to: self.view, offset: ViewController.safeAreaInsets.left)
            // Refund is initially hidden
            self.refund.isHidden = true
            debugPrint("\(ViewController.identifier) \(DebuggingIdentifiers.actionOrEventSucceded) Setup Refund!")
        }
    }

    private func setupNavigationHeader() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            // Add to subview
            self.view.addSubview(self.navigationHeader)
            // Edges to Superview, with Safe Area Insets
            self.navigationHeaderTopConstraint﻿ = self.navigationHeader.top(to: self.view, offset: ViewController.safeAreaInsets.top)
            self.navigationHeaderRightConstraint﻿ = self.navigationHeader.right(to: self.view, offset: -ViewController.safeAreaInsets.right)
            self.navigationHeaderLeftConstraint﻿ = self.navigationHeader.left(to: self.view, offset: ViewController.safeAreaInsets.left)
            // The height is always 110
            self.navigationHeader.height(110)
            // Navigation Header is initially hidden
            self.navigationHeader.isHidden = true
            debugPrint("\(ViewController.identifier) \(DebuggingIdentifiers.actionOrEventSucceded) Setup Navigation Header!")
        }
    }
}
