//
//  getStoreKitIntroductoryOfferDetailString.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 3/18/23.
//

import Foundation
import UIKit
import StoreKit

func getStoreKitIntroductoryOfferDetailString(product: Product) -> String {
    if let introductoryOffer = product.subscription?.introductoryOffer, let currentContent = LanguageCoordinator.shared.currentContent {

        let productTileContent = currentContent.productTile
        let transactionLabelContent = currentContent.transactionLabel

        let introductoryOfferPaymentMode = introductoryOffer.paymentMode
        let introductoryOfferPrice = introductoryOffer.displayPrice
        let introductoryOfferPeriod = getStoreKitSubscriptionIntroductoryOfferPeriodString(product: product, detailString: true)

        let subscriptionPeriod = getStoreKitSubscriptionPeriodString(product: product)
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
