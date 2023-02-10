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
        self.view.backgroundColor = .white
        ViewController.safeAreaInsets = self.view.safeAreaInsets
        self.setupCoordinators()
        self.setupUI()
        getDeviceOrientation()
    }

    override func viewSafeAreaInsetsDidChange() {
        ViewController.safeAreaInsets = self.view.safeAreaInsets
        debugPrint("\(ViewController.identifier) \(DebuggingIdentifiers.actionOrEventSucceded) Updated Safe Area Insets: \(ViewController.safeAreaInsets)")
        self.updateConstraints()
    }

    // MARK: Setup Functionality

    func setupCoordinators() {
        debugPrint("\(ViewController.identifier) \(DebuggingIdentifiers.actionOrEventInProgress) Setting Up Coordinators.")
        // DataCoordinator
        DataCoordinator.shared.initialize()
        // LanguageCoordinator
        LanguageCoordinator.shared.initialize()
        LanguageCoordinator.shared.onContentUpdate = { [weak self] in
            guard let _ = self, let currentContent = LanguageCoordinator.shared.currentContent else {
                debugPrint("\(ViewController.identifier) \(DebuggingIdentifiers.actionOrEventFailed) Could not update current content - as current content does not exist.")
                return
            }
            // Carry out your content update functionality here.
            // This can range from refreshing your application or could be used to send a notification to complete specific updates at chosen locations within your application.
            debugPrint("\(ViewController.identifier) \(DebuggingIdentifiers.actionOrEventSucceded) content sample : \(currentContent.sample)")
            // Send the Notification
            debugPrint("\(ViewController.identifier) \(DebuggingIdentifiers.notificationSent) Sent OnContentUpdate!")
            NotificationCenter.default.post(
                name: SystemNotifications.onContentUpdate,
                object: nil,
                userInfo: ["customVariable": currentContent.sample.sampleString]
            )

        }
    }
}
