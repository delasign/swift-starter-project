//
//  NavigationButton+Notifications.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 9/13/23.
//

import Foundation

extension NavigationButton {
    func setupNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.onExperienceStateUpdate),
            name: SystemNotifications.onExperienceStateUpdate,
            object: nil
        )
    }

    @objc func onExperienceStateUpdate() {
        debugPrint("\(NavigationButton.identifier) onExperienceStateUpdate \(DebuggingIdentifiers.notificationRecieved)")
        onStateUpdate()
    }
}
