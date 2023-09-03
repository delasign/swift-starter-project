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

    public func sendOnExperienceStateUpdate() {
        debugPrint("\(NotificationCoordinator.identifier) \(DebuggingIdentifiers.notificationSent) Sent onExperienceStateUpdate!")
        NotificationCenter.default.post(
            name: SystemNotifications.onExperienceStateUpdate,
            object: nil,
            userInfo: nil
        )
    }

    public func sendOnUpdatedData() {
        debugPrint("\(NotificationCoordinator.identifier) \(DebuggingIdentifiers.notificationSent) Sent onUpdatedData!")
        NotificationCenter.default.post(
            name: SystemNotifications.onUpdatedData,
            object: nil,
            userInfo: nil
        )
    }
}
