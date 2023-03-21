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
    static var experienceState: ExperienceStates = .landing {
        didSet {
            debugPrint("\(ViewController.identifier) experienceState didSet \(DebuggingIdentifiers.actionOrEventSucceded) Updated experience state to : \(self.experienceState)")
            // Notify App of Experience State Update
            NotificationCenter.default.post(name: SystemNotifications.onExperienceStateUpdate, object: nil, userInfo: ["experienceState": self.experienceState])
            debugPrint("\(ViewController.identifier) experienceState didSet \(DebuggingIdentifiers.notificationSent) Sent Experience Update Notification")
        }
    }
    // MARK: UI
    /// Landing
    let landing: Landing = Landing()
    var landingTopConstraint﻿: NSLayoutConstraint?
    var landingRightConstraint﻿: NSLayoutConstraint?
    var landingBottomConstraint﻿: NSLayoutConstraint?
    var landingLeftConstraint﻿: NSLayoutConstraint?
    /// Offering
    let offering: Offering = Offering()
    var offeringTopConstraint﻿: NSLayoutConstraint?
    var offeringRightConstraint﻿: NSLayoutConstraint?
    var offeringBottomConstraint﻿: NSLayoutConstraint?
    var offeringLeftConstraint﻿: NSLayoutConstraint?
    /// Refund
    let refund: Refund = Refund()
    var refundTopConstraint﻿: NSLayoutConstraint?
    var refundRightConstraint﻿: NSLayoutConstraint?
    var refundBottomConstraint﻿: NSLayoutConstraint?
    var refundLeftConstraint﻿: NSLayoutConstraint?
    /// Navigation Header
    let navigationHeader: NavigationHeader = NavigationHeader()
    var navigationHeaderTopConstraint﻿: NSLayoutConstraint?
    var navigationHeaderRightConstraint﻿: NSLayoutConstraint?
    var navigationHeaderLeftConstraint﻿: NSLayoutConstraint?

    /// StoreKitProductNotification
    let storeKitProductNotification: StoreKitProductNotification = StoreKitProductNotification()
    var storeKitProductNotificationTopConstraint﻿: NSLayoutConstraint?

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        ViewController.safeAreaInsets = self.view.safeAreaInsets
        self.setupNotifications()
        self.setupCoordinators()
        self.setupUI()
    }

    override func viewSafeAreaInsetsDidChange() {
        ViewController.safeAreaInsets = self.view.safeAreaInsets
        debugPrint("\(ViewController.identifier) \(DebuggingIdentifiers.actionOrEventSucceded) Updated Safe Area Insets: \(ViewController.safeAreaInsets)")
        self.updateConstraints()
    }

    // MARK: Setup Functionality

    func setupCoordinators() {
        debugPrint("\(ViewController.identifier) \(DebuggingIdentifiers.actionOrEventInProgress) Setting Up Coordinators.")
        // StoreKit Coordinator
        StoreKitCoordinator.shared.initialize()
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
            NotificationCenter.default.post(
                name: SystemNotifications.onContentUpdate,
                object: nil,
                userInfo: nil
            )
            debugPrint("\(ViewController.identifier) \(DebuggingIdentifiers.notificationSent) Sent OnContentUpdate!")

        }
    }
}
