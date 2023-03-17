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
    }

    let productTile: ProductTile

    struct PurchaseButton: Codable {
        let free: String
    }

    let purchaseButton: PurchaseButton

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
