//
//  SubscriptionTiers.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 2/22/23.
//
import Foundation

// Define our app's subscription tiers by level of service, in ascending order.
enum SubscriptionTier: Int, Comparable {
    case none = 0
    case standard = 1
    case premium = 2

    public static func < (lhs: Self, rhs: Self) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}
