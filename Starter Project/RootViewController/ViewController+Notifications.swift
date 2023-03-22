//
//  ViewController+Notifications.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 3/8/23.
//

import Foundation
import UIKit

extension ViewController {
    // The setupNotifications function should be the only publically available class in this extension.
    func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.onReturnToForeGround), name: UIApplication.willEnterForegroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateExperienceState), name: SystemNotifications.updateExperienceState, object: nil)
    }
    // MARK: Notification Setup Functionality
    @objc private func onReturnToForeGround() {
        // Update StoreKit statuses every time the app returns to the foreground
        Task {
            await StoreKitCoordinator.shared.updateCustomerProductStatus()
        }
    }
    
    @objc private func updateExperienceState(notification: Notification) {
        guard let userInfo = notification.userInfo, let state = userInfo[kExperienceStateUserInfo] as? ExperienceStates else {
            debugPrint("\(Landing.identifier) updateExperienceState \(DebuggingIdentifiers.actionOrEventFailed) Update Experience State has no state.")
            return
        }
        debugPrint("\(Landing.identifier) updateExperienceState \(DebuggingIdentifiers.notificationRecieved) Recieved Update Expeirence State with State : \(state)")
        // Update the state
        ViewController.experienceState = state
        // Update the experience
        self.onStateUpdate()
    }
}
