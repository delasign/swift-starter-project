//
//  StoreKitCoordinator+Purchase.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 2/22/23.
//

import Foundation
import StoreKit

extension StoreKitCoordinator {
    func purchase(_ product: Product) async throws -> Transaction? {
        debugPrint("\(StoreKitCoordinator.identifier) purchase \(DebuggingIdentifiers.actionOrEventInProgress) Purchasing product \(product.displayName)... \(DebuggingIdentifiers.actionOrEventInProgress)")
        // Begin purchasing the `Product` the user selects.
        let result = try await product.purchase()

        switch result {
        case .success(let verification):
            debugPrint("\(StoreKitCoordinator.identifier) purchase \(DebuggingIdentifiers.actionOrEventSucceded) Product Purchased.")
            debugPrint("\(StoreKitCoordinator.identifier) purchase \(DebuggingIdentifiers.actionOrEventInProgress) Verifying... \(DebuggingIdentifiers.actionOrEventInProgress)")
            // Check whether the transaction is verified. If it isn't,
            // this function rethrows the verification error.
            let transaction = try checkVerified(verification)
            debugPrint("\(StoreKitCoordinator.identifier) purchase \(DebuggingIdentifiers.actionOrEventSucceded) Verified.")
            // The transaction is verified. Deliver content to the user.
            debugPrint("\(StoreKitCoordinator.identifier) purchase \(DebuggingIdentifiers.actionOrEventInProgress) Updating Product status... \(DebuggingIdentifiers.actionOrEventInProgress)")
            await updateCustomerProductStatus()
            debugPrint("\(StoreKitCoordinator.identifier) purchase \(DebuggingIdentifiers.actionOrEventSucceded) Updated product status.")
            // Always finish a transaction - This removes transactions from the queue and it tells Apple that the customer has recieved their items or service.
            await transaction.finish()
            // Send Notification
            NotificationCenter.default.post(Notification(name: SystemNotifications.onStoreKitProductUpdate, userInfo: [
                kStoreKitNotificationUpdateTypeUserInfo: StoreKitNotificationType.purchased,
                kStoreKitNotificationUpdateProductUserInfo: product
            ]))
            debugPrint("\(StoreKitCoordinator.identifier) purchase \(DebuggingIdentifiers.actionOrEventSucceded) Finished transaction.")
            return transaction
        case .pending:
            debugPrint("\(StoreKitCoordinator.identifier) purchase \(DebuggingIdentifiers.actionOrEventFailed) Failed as the transaction is pending.")
            // Send Notification
            NotificationCenter.default.post(Notification(name: SystemNotifications.onStoreKitProductUpdate, userInfo: [
                kStoreKitNotificationUpdateTypeUserInfo: StoreKitNotificationType.pending,
                kStoreKitNotificationUpdateProductUserInfo: product
            ]))
            return nil
        case .userCancelled:
            debugPrint("\(StoreKitCoordinator.identifier) purchase \(DebuggingIdentifiers.actionOrEventFailed) Failed as the user cancelled the purchase.")
            return nil
        default:
            debugPrint("\(StoreKitCoordinator.identifier) purchase \(DebuggingIdentifiers.actionOrEventFailed) Failed with result \(result).")
            // Send Notification
            NotificationCenter.default.post(Notification(name: SystemNotifications.onStoreKitProductUpdate, userInfo: [
                kStoreKitNotificationUpdateTypeUserInfo: StoreKitNotificationType.failed,
                kStoreKitNotificationUpdateProductUserInfo: product
            ]))
            return nil
        }
    }
}
