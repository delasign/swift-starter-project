//
//  openStoreKitManageSubscriptionPreferences.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 3/21/23.
//

import Foundation
import UIKit
import StoreKit

extension UIView {
    func openStoreKitManageSubscriptionPreferences() async {
        guard let windowScene = self.window?.windowScene else {
            debugPrint("openStoreKitManagePreferences \(DebuggingIdentifiers.actionOrEventFailed) Failed to open StoreKit Manage Subscription Preferences as windowscene does not exist.")
            return
        }
        do {
            try await StoreKit.AppStore.showManageSubscriptions(in: windowScene)
            debugPrint("openStoreKitManagePreferences \(DebuggingIdentifiers.actionOrEventSucceded) Opened StoreKit Manage Subscription Preferences.")
        } catch {
            debugPrint("openStoreKitManagePreferences \(DebuggingIdentifiers.actionOrEventFailed) Failed to open StoreKit Manage Subscription Preferences with error \(error).")
        }
    }
}
