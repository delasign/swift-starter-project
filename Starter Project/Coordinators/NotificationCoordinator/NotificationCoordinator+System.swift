//
//  NotificationCoordinator+System.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 8/29/23.
//

import Foundation

extension NotificationCoordinator {
    public func sendOnContentUpdate() {
        debugPrint("\(NotificationCoordinator.identifier) \(DebuggingIdentifiers.notificationSent) Sent onContentUpdate!")
        NotificationCenter.default.post(
            name: SystemNotifications.onContentUpdate,
            object: nil,
            userInfo: nil
        )
    }
}
