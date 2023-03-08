//
//  NavigationHeader+Notifications.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 3/8/23.
//

import Foundation
import UIKit

extension NavigationHeader {
    // The setupNotifications function should be the only publically available class in this extension.
    func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.onExperienceStateUpdate), name: SystemNotifications.onExperienceStateUpdate, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.onSystemUpdatedContent), name: SystemNotifications.onContentUpdate, object: nil)
    }

    // MARK: Notification Setup Functionality
    @objc private func onExperienceStateUpdate() {
        debugPrint("\(NavigationHeader.identifier) onExperienceStateUpdate \(DebuggingIdentifiers.notificationRecieved) Recieved On Experience State Update.")
        self.onStateUpdate()
    }

    @objc private func onSystemUpdatedContent(notification: Notification) {
        debugPrint("\(NavigationHeader.identifier) onSystemUpdatedContent \(DebuggingIdentifiers.notificationRecieved) Recieved On Content Update.")
        self.onContentUpdate()
    }
}
