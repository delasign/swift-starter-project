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
        // LanguageCoordinator
        LanguageCoordinator.shared.initialize()
    }
}
