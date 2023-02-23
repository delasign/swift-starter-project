//
//  StoreKitCoordinator+Update.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 2/22/23.
//

import Foundation
import StoreKit

extension StoreKitCoordinator {
    func updateCustomerProductStatus() async {
        debugPrint("\(StoreKitCoordinator.identifier) updateCustomerProductStatus \(DebuggingIdentifiers.actionOrEventInProgress) Updating Customer Product Status... \(DebuggingIdentifiers.actionOrEventInProgress)")
        var purchasedNonConsumables: [Product] = []
        var purchasedSubscriptions: [Product] = []
        var purchasedNonRenewableSubscriptions: [Product] = []

        // Iterate through all of the user's purchased products.
        for await result in Transaction.currentEntitlements {
            do {
                debugPrint("\(StoreKitCoordinator.identifier) updateCustomerProductStatus \(DebuggingIdentifiers.actionOrEventInProgress) Checking verification for product \(result.debugDescription)... \(DebuggingIdentifiers.actionOrEventInProgress)")
                // Check whether the transaction is verified. If it isn’t, catch `failedVerification` error.
                let transaction = try checkVerified(result)

                // Check the `productType` of the transaction and get the corresponding product from the store.
                switch transaction.productType {
                case .nonConsumable:
                    if let nonConsumable = nonConsumables.first(where: { $0.id == transaction.productID }) {
                        purchasedNonConsumables.append(nonConsumable)
                        debugPrint("\(StoreKitCoordinator.identifier) updateCustomerProductStatus \(DebuggingIdentifiers.actionOrEventSucceded) Non-Consumable added to purchased Non-Consumables.")
                    } else {
                        debugPrint("\(StoreKitCoordinator.identifier) updateCustomerProductStatus \(DebuggingIdentifiers.actionOrEventFailed) Non-Consumable Product Id not within the offering : \(transaction.productID).")
                    }
                case .nonRenewable:
                    if let nonRenewable = nonRenewables.first(where: { $0.id == transaction.productID }) {
                        // Non-renewing subscriptions have no inherent expiration date, so they're always
                        // contained in `Transaction.currentEntitlements` after the user purchases them.
                        // This app defines this non-renewing subscription's expiration date to be one year after purchase.
                        // If the current date is within one year of the `purchaseDate`, the user is still entitled to this
                        // product.
                        let currentDate = Date()
                        let expirationDate = Calendar(identifier: .gregorian).date(byAdding: DateComponents(year: 1),
                                                                                   to: transaction.purchaseDate)!

                        if currentDate < expirationDate {
                            purchasedNonRenewableSubscriptions.append(nonRenewable)
                            debugPrint("\(StoreKitCoordinator.identifier) updateCustomerProductStatus \(DebuggingIdentifiers.actionOrEventSucceded) Non-Renewing Subscription added to purchased non-renewing subscriptions.")
                        } else {
                            debugPrint("\(StoreKitCoordinator.identifier) updateCustomerProductStatus \(DebuggingIdentifiers.actionOrEventFailed) Non-Renewing Subscription with Id  \(transaction.productID) expired.")
                        }
                    } else {
                        debugPrint("\(StoreKitCoordinator.identifier) updateCustomerProductStatus \(DebuggingIdentifiers.actionOrEventFailed) Non-Renewing Subscription Product Id not within the offering : \(transaction.productID).")
                    }
                case .autoRenewable:
                    if let subscription = subscriptions.first(where: { $0.id == transaction.productID }) {
                        purchasedSubscriptions.append(subscription)
                        debugPrint("\(StoreKitCoordinator.identifier) updateCustomerProductStatus \(DebuggingIdentifiers.actionOrEventSucceded) Auto-Renewable Subscription added to purchased auto-renewable subscriptions.")
                    } else {
                        debugPrint("\(StoreKitCoordinator.identifier) updateCustomerProductStatus \(DebuggingIdentifiers.actionOrEventFailed) Auto-Renewable Subscripton Product Id not within the offering : \(transaction.productID).")
                    }
                default:
                    debugPrint("\(StoreKitCoordinator.identifier) updateCustomerProductStatus \(DebuggingIdentifiers.actionOrEventFailed) Hit default \(transaction.productID).")
                    break
                }
            } catch {
                debugPrint("\(StoreKitCoordinator.identifier) updateCustomerProductStatus \(DebuggingIdentifiers.actionOrEventFailed) failed to grant product access \(result.debugDescription).")
            }
        }
        debugPrint("\(StoreKitCoordinator.identifier) updateCustomerProductStatus \(DebuggingIdentifiers.actionOrEventInProgress) Updating Purchased Arrays... \(DebuggingIdentifiers.actionOrEventInProgress)")

        // Update the store information with the purchased products.
        self.purchasedConsumables = purchasedNonConsumables
        self.purchasedNonRenewables = purchasedNonRenewableSubscriptions

        // Update the store information with auto-renewable subscription products.
        self.purchasedSubscriptions = purchasedSubscriptions

        debugPrint("\(StoreKitCoordinator.identifier) updateCustomerProductStatus \(DebuggingIdentifiers.actionOrEventSucceded) Updated Purchased arrays.")

        debugPrint("\(StoreKitCoordinator.identifier) updateCustomerProductStatus \(DebuggingIdentifiers.actionOrEventInProgress) Updating Subscription Group Status... \(DebuggingIdentifiers.actionOrEventInProgress)")
        // Check the `subscriptionGroupStatus` to learn the auto-renewable subscription state to determine whether the customer
        // is new (never subscribed), active, or inactive (expired subscription). This app has only one subscription
        // group, so products in the subscriptions array all belong to the same group. The statuses that
        // `product.subscription.status` returns apply to the entire subscription group.
        subscriptionGroupStatus = try? await subscriptions.first?.subscription?.status.first?.state
        debugPrint("\(StoreKitCoordinator.identifier) updateCustomerProductStatus \(DebuggingIdentifiers.actionOrEventSucceded) Updated Subscription Group Status.")
    }
}
