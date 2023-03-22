//
//  SystemNotifications.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 7/18/22.
//

import Foundation

struct SystemNotifications {
    // Send this notification when the LanguageCoordinator content is ready or updates language.
    static let onContentUpdate: Notification.Name = Notification.Name("onContentUpdate")
    // Experience State
    static let updateExperienceState: Notification.Name = Notification.Name("updateExperienceState")
    static let onExperienceStateUpdate: Notification.Name = Notification.Name("onExperienceStateUpdate")
    // StoreKit
    static let onStoreKitUpdate: Notification.Name = Notification.Name("onStoreKitUpdate")
    static let onStoreKitProductUpdate: Notification.Name = Notification.Name("onStoreKitProductUpdate")
    static let onStoreKitProductRefundUpdate: Notification.Name = Notification.Name("onStoreKitProductRefundUpdate")
}
