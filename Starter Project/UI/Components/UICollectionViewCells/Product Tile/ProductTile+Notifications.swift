//
//  ProductTile+Notifications.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 3/18/23.
//
import Foundation
import UIKit
import StoreKit

extension ProductTile {
    // The setupNotifications function should be the only publically available class in this extension.
    func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateOfferingTileStatus), name: SystemNotifications.onStoreKitUpdate, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.onStoreKitProductUpdate), name: SystemNotifications.onStoreKitProductUpdate, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.onStoreKitProductRefundUpdate), name: SystemNotifications.onStoreKitProductRefundUpdate, object: nil)
    }
    // MARK: Notification Setup Functionality
    @objc private func updateOfferingTileStatus() {
        guard self.collectionViewType == .offering else {
            debugPrint("\(ProductTile.identifier) updateStatus \(DebuggingIdentifiers.actionOrEventFailed) Status did not update as it is not in the offering section.")
            return
        }
        debugPrint("\(ProductTile.identifier) updateStatus \(DebuggingIdentifiers.notificationRecieved) Recieved On StoreKit Update.")
        // MARK: Update Status Only Update under certain conditions
        // The conditions are outlined below.
        DispatchQueue.main.async { [weak self] in
            guard let self = self, let product = self.product else { return }

            // MARK: If the product has been purchased, isn't in the refund section and wasn't previously purchased.
            if StoreKitCoordinator.shared.isPurchased(product) && self.type != .purchased && self.type != .refund {
                switch product.type {
                case .nonConsumable:
                    self.update(collectionViewType: .offering, type: .purchased, product: product)
                    break
                case .nonRenewable:
                    self.update(collectionViewType: .offering, type: .activeUntil, product: product)
                case .autoRenewable:
                    self.update(collectionViewType: .offering, type: .autoRenewablePurchased, product: product)
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
                    self.update(collectionViewType: .offering, type: .price, product: product)
                    break
                case .autoRenewable:
                    // Do Nothing - this can never happen
                    break
                case .consumable:
                    // Do Nothing - this can never happen
                    break
                default:
                    fatalError("ALL PRODUCT TYPES NOT CONSIDERED IN UPDATE FROM PURCHASED TO BUYABLE.")
                }
            }
            // MARK: If the subscription was initially purchased and is no longer available due to a refund.
            // Please note that this does not respond to deletions in transactions that occur locally in XCode.
            else if self.type == .autoRenewablePurchased && !StoreKitCoordinator.shared.isPurchased(product) {

                switch product.type {
                case .nonConsumable, .nonRenewable:
                    // Do Nothing - this can never happen
                    break
                case .autoRenewable:
                    Task {
                        // If the introductory offer is valid and the introductory offer exists, update to introductory offer - else update to buy subscription
                        let valid = await StoreKitCoordinator.shared.isIntroductoryOfferValid(product: product)
                        DispatchQueue.main.async { [weak self] in
                            guard let self = self else { return }
                            if valid && product.subscription?.introductoryOffer != nil {
                                self.update(collectionViewType: .offering, type: .buySubscriptionWithIntroductoryOffer, product: product)
                            } else {
                                self.update(collectionViewType: .offering, type: .buySubscription, product: product)
                            }
                        }
                    }

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

    @objc private func onStoreKitProductUpdate(notification: Notification) {
        guard self.collectionViewType == .offering, let userInfo = notification.userInfo, let type = userInfo[kStoreKitNotificationTypeUserInfo] as? StoreKitNotificationType, let inComingProduct = userInfo[kStoreKitNotificationProductUserInfo] as? Product, let product = self.product else {
            debugPrint("\(ProductTile.identifier) onStoreKitProductUpdate \(DebuggingIdentifiers.notificationRecieved) Failed to process as theres no type or product.")
            return
        }

        debugPrint("\(ProductTile.identifier) onStoreKitProductUpdate \(DebuggingIdentifiers.notificationRecieved) Recieved On StoreKit Update with type \(type) and product \(product).")

        if type == .pending, inComingProduct.id == product.id {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.update(collectionViewType: .offering, type: .pending, product: product)
            }
        }
    }

    @objc private func onStoreKitProductRefundUpdate(notification: Notification) {
        guard self.collectionViewType == .refund, let userInfo = notification.userInfo, let type = userInfo[kStoreKitNotificationTypeUserInfo] as? StoreKitNotificationType, let inComingProduct = userInfo[kStoreKitNotificationProductUserInfo] as? Product, let product = self.product else {
            debugPrint("\(ProductTile.identifier) onStoreKitProductRefundUpdate \(DebuggingIdentifiers.notificationRecieved) Failed to process as theres no type or product.")
            return
        }

        debugPrint("\(ProductTile.identifier) onStoreKitProductRefundUpdate \(DebuggingIdentifiers.notificationRecieved) Recieved On StoreKit Update with type \(type) and product \(product).")

        if inComingProduct.id == product.id {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                let tileType: ProductTileType
                switch type {
                case .refundSucceeded:
                    tileType = .purchased
                    break
                case .refundPending:
                    tileType = .pending
                    break
                case .refundCancelled, .refundFailed:
                    tileType = .refund
                    break
                default:
                    return
                }
                self.update(collectionViewType: .refund, type: tileType, product: product)
            }
        }
    }
}
