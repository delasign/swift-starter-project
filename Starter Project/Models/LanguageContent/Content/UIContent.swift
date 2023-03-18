//
//  UIContent.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 7/13/22.
//

import Foundation
import UIKit

struct UIContent: Codable {
    struct Shared: Codable {
        let consumables: String
        let nonConsumables: String
        let nonRenewingSubscriptions: String
        let autoRenewingSubscriptions: String
        let individualPlans: String
        let familyPlans: String
        let requestARefund: String
        let missing: String
        let error: String
    }

    let shared: Shared

    struct Landing: Codable {
        let tutorialLabel: String
        let visitOurBlog: String
        let start: String
    }

    let landing: Landing

    struct Offering: Codable {
        let header: String
        let redeemOfferCode: String
        let restorePurchasesPrompt: String
        let restorePurchases: String
    }

    let offering: Offering

    struct Refund: Codable {
        let header: String
        let noRefundsAvailable: String
    }

    let refund: Refund

    struct ProductTile: Codable {
        let stock: String
        let nonRenewingActiveUntil: String
        let autoRenewableRenewsOn: String
        let manageSubscription: String
        let autoRenewableWillExpire: String
        let autoRenewableWillExpireMessage: String
        let autoRenewableGracePeriod: String
        let autoRenewableGracePeriodMessage: String
        let get: String
        let purchase: String
        let claimOffer: String
        let introductoryOfferPayLeadingText: String
        let introductoryOfferPayAsYouGoLeadingPeriodText: String
        let introductoryOfferPayAsYouGoLeadingTotalLengthText: String
        let introductoryOfferPayUpFrontLeadingPeriodText: String
        let introductoryOfferPostOfferPricingText: String
        let introductoryOfferPostOfferPeriodText: String
        let introductoryOfferFreeLeadingText: String
        let introductoryOfferFree: String
    }

    let productTile: ProductTile

    struct TransactionLabel: Codable {
        let free: String
        let weekly: String
        let monthly: String
        let everyTwoMonths: String
        let everyThreeMonths: String
        let everySixMonths: String
        let yearly: String
    }

    let transactionLabel: TransactionLabel

    struct Notifications: Codable {
        let success: String
        let pendingPrefix: String
        let pendingSuffix: String
        let failedPrefix: String
        let failedSuffix: String
        let refund: String
    }

    let notifications: Notifications
}
