//
//  StoreKitCoordinator+Verify.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 2/22/23.
//

import Foundation
import StoreKit

extension StoreKitCoordinator {
    func isPurchased(_ product: Product) async throws -> Bool {
        debugPrint("\(StoreKitCoordinator.identifier) isPurchased \(DebuggingIdentifiers.actionOrEventInProgress) Checking if the product is purchased... \(DebuggingIdentifiers.actionOrEventInProgress)")
        // Determine whether the user purchases a given product.
        switch product.type {
        case .nonRenewable:
            debugPrint("\(StoreKitCoordinator.identifier) isPurchased \(DebuggingIdentifiers.actionOrEventSucceded) Non-Renewing Subscription has been purchased.")
            return purchasedNonRenewables.contains(product)
        case .nonConsumable:
            debugPrint("\(StoreKitCoordinator.identifier) isPurchased \(DebuggingIdentifiers.actionOrEventSucceded) Non-Consumable has been purchased.")
            return purchasedNonConsumables.contains(product)
        case .autoRenewable:
            debugPrint("\(StoreKitCoordinator.identifier) isPurchased \(DebuggingIdentifiers.actionOrEventSucceded) Auto-Renewable Subscription has been purchased.")
            return purchasedIndividualSubscriptions.contains(product) || purchasedFamilySubscriptions.contains(product)
        case .consumable:
            debugPrint("\(StoreKitCoordinator.identifier) isPurchased \(DebuggingIdentifiers.actionOrEventFailed) Consumables cannot be checked off as purchased.")
            // Consumables can be purchased more than once, so never show them as purchased.
            return false
        default:
            debugPrint("\(StoreKitCoordinator.identifier) isPurchased \(DebuggingIdentifiers.actionOrEventFailed) Failed as the type '\(product.type)' is unidentified.")
            return false
        }
    }

    func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
        debugPrint("\(StoreKitCoordinator.identifier) checkVerified \(DebuggingIdentifiers.actionOrEventInProgress) Checking verification... \(DebuggingIdentifiers.actionOrEventInProgress)")
        // Check whether the JWS passes StoreKit verification.
        switch result {
        case .unverified:
            debugPrint("\(StoreKitCoordinator.identifier) checkVerified \(DebuggingIdentifiers.actionOrEventFailed) Not veriied.")
            // StoreKit parses the JWS, but it fails verification.
            throw StoreError.failedVerification
        case .verified(let safe):
            debugPrint("\(StoreKitCoordinator.identifier) checkVerified \(DebuggingIdentifiers.actionOrEventSucceded) Veriied.")
            // The result is verified. Return the unwrapped value.
            return safe
        }
    }
}
