//
//  ProductTile+Notifications.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 3/18/23.
//
import Foundation
import UIKit

extension ProductTile {
    // The setupNotifications function should be the only publically available class in this extension.
    func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateStatus), name: SystemNotifications.onStoreKitUpdate, object: nil)
    }
    // MARK: Notification Setup Functionality
    @objc private func updateStatus() {
        debugPrint("\(ProductTile.identifier) updateStatus \(DebuggingIdentifiers.notificationRecieved) Recieved On StoreKit Update.")
        // MARK: Update Status Only Update under certain conditions
        // The conditions are outlined below.
        DispatchQueue.main.async { [weak self] in
            guard let self = self, let product = self.product else { return }
            
            // MARK: If the product has been purchased and wasn't previously purchased.
            if StoreKitCoordinator.shared.isPurchased(product) && self.type != .purchased {
                switch product.type {
                case .nonConsumable:
                    self.update(type: .purchased, product: product)
                    break
                case .nonRenewable:
                    self.update(type: .activeUntil, product: product)
                case .autoRenewable:
                    self.update(type: .autoRenewablePurchased, product: product)
                    break
                case .consumable:
                    // Do Nothing - this can never happen
                    break
                default:
                    fatalError("ALL PRODUCT TYPES NOT CONSIDERED IN UPDATE FROM BUYABLE TO PURCHASED.")
                }
            }
            // MARK: If the product was initially purchased and is no longer available due to a refund.
            // Please note that this does not respond to deletions in transactions that occur locally in XCode.
            else if self.type == .purchased && !StoreKitCoordinator.shared.isPurchased(product) {

                switch product.type {
                case .nonConsumable, .nonRenewable:
                    self.update(type: .price, product: product)
                    break
                case .autoRenewable:
                    self.update(type: product.subscription?.introductoryOffer == nil ? .buySubscription : .buySubscriptionWithIntroductoryOffer, product: product)
                    break
                case .consumable:
                    // Do Nothing - this can never happen
                    break
                default:
                    fatalError("ALL PRODUCT TYPES NOT CONSIDERED IN UPDATE FROM PURCHASED TO BUYABLE.")
                }
            }
        }
    }
}
