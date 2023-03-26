//
//  StoreKitCoordinator.+SubscriptionPeriod.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 3/26/23.
//

import Foundation
import UIKit
import StoreKit

extension StoreKitCoordinator {
    // MARK: is Offer Valid ?
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

    // MARK: Introductory Offer Period Details
    func getSubscriptionIntroductoryOfferPeriodString(product: Product, detailString: Bool) -> String {
        if let introductoryOffer = product.subscription?.introductoryOffer, let currentContent = LanguageCoordinator.shared.currentContent {

            let unit = introductoryOffer.period.unit
            let value = introductoryOffer.period.value

            switch unit {
            case .day:
                return "ERROR"
            case .week:
                return currentContent.transactionLabel.weekly
            case .month:
                switch value {
                case 1:
                    if detailString {
                        return currentContent.transactionLabel.everyOneMonth
                    } else {
                        return currentContent.transactionLabel.monthly
                    }
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

    func getIntroductoryOfferDetailString(product: Product) -> String {
        if let introductoryOffer = product.subscription?.introductoryOffer, let currentContent = LanguageCoordinator.shared.currentContent {

            let productTileContent = currentContent.productTile
            let transactionLabelContent = currentContent.transactionLabel

            let introductoryOfferPaymentMode = introductoryOffer.paymentMode
            let introductoryOfferPrice = introductoryOffer.displayPrice
            let introductoryOfferPeriod = getSubscriptionIntroductoryOfferPeriodString(product: product, detailString: true)

            let subscriptionPeriod = getSubscriptionPeriodString(product: product)
            let subscriptionPrice = product.displayPrice

            let leadingOfferString: String
            switch introductoryOfferPaymentMode {
            case .payAsYouGo:
                leadingOfferString = productTileContent.introductoryOfferPayLeadingText + introductoryOfferPrice + productTileContent.introductoryOfferPayAsYouGoLeadingPeriodText + transactionLabelContent.monthly + productTileContent.introductoryOfferPayAsYouGoLeadingTotalLengthText + introductoryOfferPeriod
            case .payUpFront:
                leadingOfferString = productTileContent.introductoryOfferPayLeadingText + introductoryOfferPrice + productTileContent.introductoryOfferPayUpFrontLeadingPeriodText + introductoryOfferPeriod
            case .freeTrial:
                leadingOfferString = productTileContent.introductoryOfferFreeLeadingText + introductoryOfferPeriod + productTileContent.introductoryOfferFree
            default:
                fatalError("ERROR: YOU HAVE NOT CONSIDERED ALL INTRODUCTORY PAYMENT MODE TYPES.")
            }

            return leadingOfferString + productTileContent.introductoryOfferPostOfferPricingText + subscriptionPrice + productTileContent.introductoryOfferPostOfferPeriodText + subscriptionPeriod + "."
        } else {
            return "ERROR"
        }
    }
}
