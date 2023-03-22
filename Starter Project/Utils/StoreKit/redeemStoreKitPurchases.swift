//
//  redeemStoreKitPurchases.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 3/21/23.
//

import Foundation
import UIKit
import StoreKit

extension UIView {
    func redeemStoreKitPurchases() async {
        do {
            try await StoreKit.AppStore.sync()
            debugPrint("redeemStoreKitPurchases \(DebuggingIdentifiers.actionOrEventSucceded) Restored Purchases.")
        } catch {
            debugPrint("redeemStoreKitPurchases \(DebuggingIdentifiers.actionOrEventFailed) Failed to restore purchases with error : \(error).")
        }
    }
}
