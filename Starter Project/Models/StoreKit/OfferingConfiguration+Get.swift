//
//  OfferingConfiguration+Get.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 2/22/23.
//

import Foundation

extension OfferingConfiguration {
    // Get Sample Consumable Id
    func getSampleConsumableId() -> String? {
        return getOfferingIdForKey(key: OfferingKeys.sampleConsumable.rawValue)
    }

    // Get Sample Non-Consumable Id
    func getSampleNonConsumableId() -> String? {
        return getOfferingIdForKey(key: OfferingKeys.sampleNonConsumable.rawValue)
    }

    // Get Sample Non Renewing Subscription Id
    func getSampleNonrenewingSubscriptionId() -> String? {
        return getOfferingIdForKey(key: OfferingKeys.sampleNonRenewingSubscription.rawValue)
    }

    // Get Sample Auto-Renewable Subscription Id
    func getSampleAutoRenewableSubscriptionId() -> String? {
        return getOfferingIdForKey(key: OfferingKeys.sampleAutoRenewableSubscription.rawValue)
    }

    // Get Sample Tier 2 Auto-Renewable Subscription Id
    func getSampleTierTwoAutoRenewableSubscriptionId() -> String? {
        return getOfferingIdForKey(key: OfferingKeys.sampleTierTwoAutoRenewableSubscription.rawValue)
    }
}
