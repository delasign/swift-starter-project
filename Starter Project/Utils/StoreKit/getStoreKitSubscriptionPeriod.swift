//
//  StoreKitSubscriptionPeriods.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 3/17/23.
//

import Foundation
import StoreKit

func getStoreKitSubscriptionPeriod(product: Product) -> StoreKitSubscriptionPeriod {
    if let subscription = product.subscription {

        let unit = subscription.subscriptionPeriod.unit
        let value = subscription.subscriptionPeriod.value

        switch unit {
        case .day:
            return .none
        case .week:
            return .weekly
        case .month:
            switch value {
            case 1:
                return .monthly
            case 2:
                return .everyTwoMonths
            case 3:
                return .everyThreeMonths
            case 6:
                return .everySixMonths
            default:
                fatalError("ERROR: YOU HAVE NOT CONSIDERED ALL MONTHLY VALUES.")
            }
        case .year:
            return .yearly
        @unknown default:
            fatalError("ERROR: YOU HAVE NOT CONSIDERED ALL SUBSCRIPTION UNITS.")
        }
    } else {
        return .none
    }
}
