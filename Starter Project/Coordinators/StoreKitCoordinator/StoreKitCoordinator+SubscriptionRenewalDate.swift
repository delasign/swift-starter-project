//
//  StoreKitCoordinator+SubscriptionRenewalDate.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 3/21/23.
//

import Foundation
import StoreKit

extension StoreKitCoordinator {
    func getSubscriptionRenewalOrExpirationDate(product: Product) async -> String {
        guard let currentContent = LanguageCoordinator.shared.currentContent else {
            return "Error No Content"
        }

        for await result in Transaction.currentEntitlements {
            do {
                let transaction = try checkVerified(result)
                if product.id == transaction.productID {
                    // A susbcriptions expiration date is returns the information for a renewal or expiration.
                    if let date = transaction.expirationDate {
                        return date.formatted(date: .numeric, time: .omitted)
                    } else {
                        // The product is a subscription but does not have a renewal or expiration date.
                        return currentContent.shared.missing
                    }
                }
            } catch {
                // Do Nothing
            }
        }

        return currentContent.shared.error
    }
}
