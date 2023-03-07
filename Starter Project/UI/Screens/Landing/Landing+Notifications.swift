//
//  CustomUIView+Notifications.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 7/18/22.
//

import Foundation
import UIKit
extension Landing {
    // The setupNotifications function should be the only publically available class in this extension.
    func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.onSystemUpdatedContent), name: SystemNotifications.onContentUpdate, object: nil)
    }
    // MARK: Notification Setup Functionality
    @objc private func onSystemUpdatedContent(notification: Notification) {
        debugPrint("\(Landing.identifier) onSystemUpdatedContent \(DebuggingIdentifiers.notificationRecieved) Recieved On Content Update.")
        self.onContentUpdate()
    }
}
