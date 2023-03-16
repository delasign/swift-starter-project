//
//  NavigationButton+Notifications.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 3/8/23.
//

import Foundation

extension NavigationButton {
    // The setupNotifications function should be the only publically available class in this extension.
    func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.onExperienceStateUpdate), name: SystemNotifications.onExperienceStateUpdate, object: nil)
    }

    // MARK: Notification Setup Functionality
    @objc private func onExperienceStateUpdate() {
        debugPrint("\(NavigationButton.identifier) onExperienceStateUpdate \(DebuggingIdentifiers.notificationRecieved) Recieved On Experience State Update.")
        self.onStateUpdate()
    }
}
