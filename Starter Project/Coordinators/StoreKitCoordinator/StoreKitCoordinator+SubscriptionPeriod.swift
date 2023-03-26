//
//  StoreKitCoordinator+SubscriptionPeriod.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 3/26/23.
//

import Foundation
import UIKit
import StoreKit

extension StoreKitCoordinator {
    func getSubscriptionPeriod(product: Product) -> StoreKitSubscriptionPeriod {
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

    func getSubscriptionPeriodString(product: Product) -> String {
        if let subscription = product.subscription, let currentContent = LanguageCoordinator.shared.currentContent {

            let unit = subscription.subscriptionPeriod.unit
            let value = subscription.subscriptionPeriod.value

            switch unit {
            case .day:
                return "ERROR"
            case .week:
                return currentContent.transactionLabel.weekly
            case .month:
                switch value {
                case 1:
                    return currentContent.transactionLabel.monthly
                case 2:
                    return currentContent.transactionLabel.everyTwoMonths
                case 3:
                    return currentContent.transactionLabel.everyThreeMonths
                case 6:
                    return currentContent.transactionLabel.everySixMonths
                default:
                    fatalError("ERROR: YOU HAVE NOT CONSIDERED ALL MONTHLY VALUES.")
                }
            case .year:
                return currentContent.transactionLabel.yearly
            @unknown default:
                fatalError("ERROR: YOU HAVE NOT CONSIDERED ALL SUBSCRIPTION UNITS.")
            }
        } else {
            return "ERROR"
        }
    }
}
