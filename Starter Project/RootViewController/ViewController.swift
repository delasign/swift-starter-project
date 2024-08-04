//
//  ViewController.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 7/11/22.
//

import UIKit
import ARKit

class ViewController: UIViewController {
    // MARK: Variables
    static let identifier: String = "[ViewController]"
    static var safeAreaInsets: UIEdgeInsets = .zero
    static var orientation: UIDeviceOrientation = .portrait
    static var session = ARSession()
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
    let arCameraView: ARCameraView = ARCameraView()
    var arViewTopConstraint﻿: NSLayoutConstraint?
    var arViewRightConstraint﻿: NSLayoutConstraint?
    var arViewBottomConstraint﻿: NSLayoutConstraint?
    var arViewLeftConstraint﻿: NSLayoutConstraint?
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        arCameraView.sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        arCameraView.sceneView.session.pause()
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
