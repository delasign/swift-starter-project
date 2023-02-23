//
//  StoreKitCoordinator+Get.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 2/22/23.
//

import Foundation
import StoreKit

extension StoreKitCoordinator {

    func requestProducts() async {
        debugPrint("\(StoreKitCoordinator.identifier) requestProducts \(DebuggingIdentifiers.actionOrEventInProgress) Requesting products... \(DebuggingIdentifiers.actionOrEventInProgress)")
        guard let offering = configuration.offering else {
            debugPrint("\(StoreKitCoordinator.identifier) requestProducts \(DebuggingIdentifiers.actionOrEventFailed) Failed as configuration offering does not exist.")
            return
        }
        do {
            // Request products from the App Store using the identifiers that the Products.plist file defines.
            let storeProducts = try await Product.products(for: offering.values)
            debugPrint("\(StoreKitCoordinator.identifier) requestProducts \(DebuggingIdentifiers.actionOrEventSucceded) Completed gathering Products.")

            var newConsumables: [Product] = []
            var newNonConsumables: [Product] = []
            var newSubscriptions: [Product] = []
            var newNonRenewables: [Product] = []

            // Filter the products into categories based on their type.
            for product in storeProducts {
                switch product.type {
                case .consumable:
                    newConsumables.append(product)
                    debugPrint("\(StoreKitCoordinator.identifier) requestProducts \(DebuggingIdentifiers.actionOrEventSucceded) Found consumable : \(product).")
                case .nonConsumable:
                    newNonConsumables.append(product)
                    debugPrint("\(StoreKitCoordinator.identifier) requestProducts \(DebuggingIdentifiers.actionOrEventSucceded) Found non-consumable : \(product).")
                case .autoRenewable:
                    newSubscriptions.append(product)
                    debugPrint("\(StoreKitCoordinator.identifier) requestProducts \(DebuggingIdentifiers.actionOrEventSucceded) Found auto-renewable subscription : \(product).")
                case .nonRenewable:
                    debugPrint("\(StoreKitCoordinator.identifier) requestProducts \(DebuggingIdentifiers.actionOrEventSucceded) Found non-renewable subscription : \(product).")
                    newNonRenewables.append(product)
                default:
                    // Ignore this product.
                    debugPrint("\(StoreKitCoordinator.identifier) requestProducts \(DebuggingIdentifiers.actionOrEventFailed) unknown product : \(product).")
                }
            }

            debugPrint("\(StoreKitCoordinator.identifier) requestProducts \(DebuggingIdentifiers.actionOrEventSucceded) Completed ordering Products.")

            // Sort each product category by price, lowest to highest, to update the store.
            consumables = sortByPrice(newConsumables)
            nonConsumables = sortByPrice(newNonConsumables)
            subscriptions = sortByPrice(newSubscriptions)
            nonRenewables = sortByPrice(newNonRenewables)

            debugPrint("\(StoreKitCoordinator.identifier) requestProducts \(DebuggingIdentifiers.actionOrEventSucceded) Completed updating available Products.")

        } catch {
            debugPrint("\(StoreKitCoordinator.identifier) requestProducts \(DebuggingIdentifiers.actionOrEventFailed) Failed product request from the App Store server: \(error).")
        }
    }

    private func sortByPrice(_ products: [Product]) -> [Product] {
        products.sorted(by: { return $0.price < $1.price })
    }

    // Get a subscription's level of service using the product ID.
    func getSubscriptionTier(for productId: String) -> SubscriptionTier {
        debugPrint("\(StoreKitCoordinator.identifier) getSubscriptionTier \(DebuggingIdentifiers.actionOrEventInProgress) Gathering Subscription Tier... \(DebuggingIdentifiers.actionOrEventInProgress)")
        switch productId {
        case configuration.getSampleAutoRenewableSubscriptionId():
            debugPrint("\(StoreKitCoordinator.identifier) getSubscriptionTier \(DebuggingIdentifiers.actionOrEventSucceded) Subscription is a standard tier.")
            return .standard
        case configuration.getSampleTierTwoAutoRenewableSubscriptionId():
            debugPrint("\(StoreKitCoordinator.identifier) getSubscriptionTier \(DebuggingIdentifiers.actionOrEventSucceded) Subscription is a premium tier.")
            return .premium
        default:
            debugPrint("\(StoreKitCoordinator.identifier) getSubscriptionTier \(DebuggingIdentifiers.actionOrEventFailed) There is no subscription tier.")
            return .none
        }
    }
}
