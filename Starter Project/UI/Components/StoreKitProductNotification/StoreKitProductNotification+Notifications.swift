//
//  StoreKitProductNotification+Notifications.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 3/21/23.
//

import Foundation
import StoreKit
extension StoreKitProductNotification {
    func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.onStoreKitProductNotification), name: SystemNotifications.onStoreKitProductUpdate, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.onStoreKitProductNotification), name: SystemNotifications.onStoreKitProductRefundUpdate, object: nil)
    }

    @objc private func onStoreKitProductNotification(notification: Notification) {
        guard let userInfo = notification.userInfo, let type = userInfo[kStoreKitNotificationTypeUserInfo] as? StoreKitNotificationType else {
            debugPrint("\(StoreKitProductNotification.identifier) onStoreKitProductNotification \(DebuggingIdentifiers.actionOrEventFailed) Failed as there is no type in the notification.")
            return
        }
        debugPrint("\(StoreKitProductNotification.identifier) onStoreKitProductNotification \(DebuggingIdentifiers.notificationRecieved) Recieved On StoreKit Product Notification with type : \(type).")
        // Update the type
        self.type = type
        // Set the product if its there.
        if let product = userInfo[kStoreKitNotificationProductUserInfo] as? Product {
            debugPrint("\(StoreKitProductNotification.identifier) onStoreKitProductNotification \(DebuggingIdentifiers.notificationRecieved) Includes a product : \(product).")
            self.product = product
        } else {
            debugPrint("\(StoreKitProductNotification.identifier) onStoreKitProductNotification \(DebuggingIdentifiers.actionOrEventFailed) There is no product.")
        }
        // Perform updates
        self.update()
    }

}
