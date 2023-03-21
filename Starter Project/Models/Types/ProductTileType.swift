//
//  ProductTileType.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 3/8/23.
//

import Foundation

enum ProductTileType: CaseIterable {
    case get
    case price
    case consumableBuy
    case buySubscription
    case buySubscriptionWithIntroductoryOffer
    case pending
    case purchased
    case activeUntil
    case autoRenewablePurchased
    case gracePeriod
    case billingRetry
    case expiring
    case refund
    case refundSubscription
}
