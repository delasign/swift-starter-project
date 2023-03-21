//
//  StoreKitCoordinator+SubscriptionActive.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 3/21/23.
//

import Foundation
import StoreKit

extension StoreKitCoordinator {
    func getSubscriptionStatus(product: Product) async -> StoreKitSubscriptionStatus {
        guard let subscription = product.subscription else {
            // Not a subscription
            return .none
        }
        do {
            let statuses = try await subscription.status

            for status in statuses {
                let info = try checkVerified(status.renewalInfo)
                switch status.state {
                case .subscribed:
                    if info.willAutoRenew {
                        debugPrint("getSubscriptionStatus user subscription is active.")
                        return .subscribed
                    } else {
                        debugPrint("getSubscriptionStatus user subscription is expiring.")
                        return .expiring
                    }
                case .inBillingRetryPeriod:
                    debugPrint("getSubscriptionStatus user subscription is in billing retry period.")
                    return .inBillingRetryPeriod
                case .inGracePeriod:
                    debugPrint("getSubscriptionStatus user subscription is in grace period.")
                    return .inBillingGracePeriod
                case .expired:
                    debugPrint("getSubscriptionStatus user subscription is expired.")
                    return .expired
                case .revoked:
                    debugPrint("getSubscriptionStatus user subscription was revoked.")
                    return .revoked
                default:
                    fatalError("getSubscriptionStatus WARNING STATE NOT CONSIDERED.")
                }
            }
        } catch {
            // do nothing
        }
        return .none
    }
}
