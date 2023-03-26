//
//  StoreKitCoordinator+IntroductoryOffers.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 3/19/23.
//

import Foundation
import StoreKit

extension StoreKitCoordinator {
    func isIntroductoryOfferValid(product: Product) async -> Bool {
        for await result in Transaction.all {
            do {
                let transaction = try checkVerified(result)
                if transaction.productID == product.id {
                    return false
                }
            } catch {
                // Do nothing

            }
        }
        return true
    }
}
