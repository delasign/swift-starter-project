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

            if self.type == .autoRenewablePurchased || self.type == .buySubscription || self.type == .buySubscriptionWithIntroductoryOffer {
                debugPrint("\(ProductTile.identifier) isPurchased \(DebuggingIdentifiers.notificationRecieved) \(StoreKitCoordinator.shared.isPurchased(product)) | type : \(self.type) | id : \(product.id)")
            }

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
                                self.update(type: .buySubscriptionWithIntroductoryOffer, product: product)
                            } else {
                                self.update(type: .buySubscription, product: product)
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
}
