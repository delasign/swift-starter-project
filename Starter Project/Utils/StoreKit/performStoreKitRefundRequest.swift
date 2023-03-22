//
//  performStoreKitRefundRequest.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 3/22/23.
//

import Foundation
import UIKit
import StoreKit

extension UIView {
    func performStoreKitRefundRequest(product: Product) async {
        guard let windowScene = self.window?.windowScene else {
            debugPrint("performStoreKitRefundRequest \(DebuggingIdentifiers.actionOrEventFailed) Failed to execute refund request as windowscene does not exist.")
            return
        }

        guard case .verified(let transaction) = await Transaction.latest(for: product.id) else { return }

        do {
            let status = try await transaction.beginRefundRequest(in: windowScene)
            debugPrint("performStoreKitRefundRequest \(DebuggingIdentifiers.actionOrEventSucceded) Executed refund.")
            // Send Refund Pending Notification
            NotificationCenter.default.post(Notification(name: SystemNotifications.onStoreKitProductRefundUpdate, userInfo: [
                kStoreKitNotificationTypeUserInfo: StoreKitNotificationType.refundPending,
                kStoreKitNotificationProductUserInfo: product
            ]))
            switch status {
            case .userCancelled:
                // Send Refund Cancelled Notification
                NotificationCenter.default.post(Notification(name: SystemNotifications.onStoreKitProductRefundUpdate, userInfo: [
                    kStoreKitNotificationTypeUserInfo: StoreKitNotificationType.refundCancelled,
                    kStoreKitNotificationProductUserInfo: product
                ]))
                break
            case .success:
                // Send Refund Succesful Notification
                NotificationCenter.default.post(Notification(name: SystemNotifications.onStoreKitProductRefundUpdate, userInfo: [
                    kStoreKitNotificationTypeUserInfo: StoreKitNotificationType.refundSucceeded,
                    kStoreKitNotificationProductUserInfo: product
                ]))
                break
            @unknown default:
                fatalError("CRASHED AS THE APP DID NOT CONSIDER ALL STATUSES FOR A REFUND REQUEST \(status)")
                break
            }
        } catch {
            NotificationCenter.default.post(Notification(name: SystemNotifications.onStoreKitProductRefundUpdate, userInfo: [
                kStoreKitNotificationTypeUserInfo: StoreKitNotificationType.refundFailed,
                kStoreKitNotificationProductUserInfo: product
            ]))
            debugPrint("performStoreKitRefundRequest \(DebuggingIdentifiers.actionOrEventFailed) Failed to execute refund request with error : \(error).")
        }
    }
}
