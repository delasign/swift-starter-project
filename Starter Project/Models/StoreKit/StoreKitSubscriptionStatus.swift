//
//  StoreKitSubscriptionStatus.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 3/21/23.
//

import Foundation

enum StoreKitSubscriptionStatus {
    case none
    case subscribed
    // If a user cancels, it will show up as expiring
    case expiring
    case inBillingGracePeriod
    case inBillingRetryPeriod
    case expired
    case revoked
}
