//
//  DynamicUIView+Notifications.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 3/13/23.
//

import Foundation

extension DynamicUIView {
    // The setupNotifications function should be the only publically available class in this extension.
    func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.onSystemUpdatedContent), name: SystemNotifications.onContentUpdate, object: nil)
    }
    // MARK: Notification Setup Functionality
    @objc private func onSystemUpdatedContent(notification: Notification) {
        debugPrint("\(DynamicUIView.identifier) onSystemUpdatedContent \(DebuggingIdentifiers.notificationRecieved) Recieved On Content Update.")
        // Update View
        self.update()
    }
}
