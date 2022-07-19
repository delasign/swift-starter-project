//
//  CustomUIView+Notifications.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 7/18/22.
//

import Foundation
import UIKit
extension CustomUIView {
    // The setupNotifications function should be the only publically available class in this extension.
    func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.onSystemUpdatedContent), name: SystemNotifications.onContentUpdate, object: nil)
    }
    // MARK: Notification Setup Functionality
    @objc private func onSystemUpdatedContent(notification: Notification) {
        guard let userInfo = notification.userInfo, let customVariable = userInfo["customVariable"] as? String else {
            debugPrint("\(CustomUIView.identifier) \(DebuggingIdentifiers.actionOrEventFailed) Failed to recieve notification as no userInfo exists.")
            return
        }
        debugPrint("\(CustomUIView.identifier) \(DebuggingIdentifiers.notificationRecieved) Recieved On Content Update with custom notification variable : \(customVariable)")
        self.onContentUpdate()
    }
}
