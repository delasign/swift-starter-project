//
//  ViewController.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 7/11/22.
//

import UIKit

class ViewController: UIViewController {
    // MARK: Variables
    static let identifier: String = "[ViewController]"
    static var safeAreaInsets: UIEdgeInsets = .zero
    static var orientation: UIDeviceOrientation = .portrait
    // The Experience State is managed by the UIViewController - and initially is on a "custom" state
    var experienceState: ExperienceStates = .custom {
        didSet {
            Task {
                    // Update the DataCoordinator so everyone knows
                DataCoordinator.shared.experienceState = experienceState
                // Notify the System
                await NotificationCoordinator.shared.sendOnExperienceStateUpdate()
                // Perform relevant screen changes (i.e. hide/show)
                self.onStateUpdate()
            }
        }
    }
    // MARK: UI
    let customView: CustomUIView = CustomUIView()
    var customViewTopConstraint﻿: NSLayoutConstraint?
    var customViewRightConstraint﻿: NSLayoutConstraint?
    var customViewBottomConstraint﻿: NSLayoutConstraint?
    var customViewLeftConstraint﻿: NSLayoutConstraint?
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = Styleguide.getBackgroundColor()
        ViewController.safeAreaInsets = self.view.safeAreaInsets
        self.setupCoordinators()
        self.setupUI()
        ViewController.orientation = getDeviceOrientation()
    }

    override func viewSafeAreaInsetsDidChange() {
        // Update Insets
        ViewController.safeAreaInsets = self.view.safeAreaInsets
        // Update Orientation
        ViewController.orientation = getDeviceOrientation()
        debugPrint("\(ViewController.identifier) \(DebuggingIdentifiers.actionOrEventSucceded) Updated Safe Area Insets: \(ViewController.safeAreaInsets)")
        // Update Constraints
        self.updateConstraints()
    }

    // MARK: Setup Functionality

    func setupCoordinators() {
        debugPrint("\(ViewController.identifier) \(DebuggingIdentifiers.actionOrEventInProgress) Setting Up Coordinators.")
        // DataCoordinator
        DataCoordinator.shared.initialize()
    }
}
