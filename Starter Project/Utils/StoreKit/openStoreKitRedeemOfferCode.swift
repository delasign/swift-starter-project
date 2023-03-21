//
//  openStoreKitRedeemOfferCode.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 3/21/23.
//

import Foundation
import UIKit
import StoreKit

extension UIView {
    func openStoreKitRedeemOfferCode() async {
        guard let windowScene = self.window?.windowScene else {
            debugPrint("openStoreKitRedeemOfferCode \(DebuggingIdentifiers.actionOrEventFailed) Failed to present StoreKit Offer Code Redeem Sheet as windowscene does not exist.")
            return
        }
        do {
            try await StoreKit.AppStore.presentOfferCodeRedeemSheet(in: windowScene)
            debugPrint("openStoreKitRedeemOfferCode \(DebuggingIdentifiers.actionOrEventSucceded) Presented StoreKit Offer Code Redeem Sheet.")
        } catch {
            debugPrint("openStoreKitRedeemOfferCode \(DebuggingIdentifiers.actionOrEventFailed) Failed to present StoreKit Offer Code Redeem Sheet with error \(error).")
        }
    }
}
