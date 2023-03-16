//
//  StoreKitCoordinator.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 2/22/23.
//

import Foundation
import StoreKit

class StoreKitCoordinator: NSObject {

    // MARK: Variables
    static let identifier: String = "[StoreKitCoordinator]"
    static let shared: StoreKitCoordinator = StoreKitCoordinator()
    // A configuration that holds the Ids and the functionality to access them.
    let configuration: OfferingConfiguration = OfferingConfiguration()
    // A transaction listener to listen to transactions on init and through out the apps use.
    private var updateListenerTask: Task<Void, Error>?

    // MARK: Offering Arrays
    // Arrays are initially empty and are filled in when we gather the products
    public var consumables: [Product] = []
    public var nonConsumables: [Product] = []
    public var individualSubscriptions: [Product] = []
    public var familySubscriptions: [Product] = []
    public var nonRenewables: [Product] = []
    // Arrays that hold the purchases products
    public var purchasedConsumables: [Product] = []
    public var purchasedNonConsumables: [Product] = []
    public var purchasedIndividualSubscriptions: [Product] = []
    public var purchasedFamilySubscriptions: [Product] = []
    public var purchasedNonRenewables: [Product] = []
    // A variable to hold the Subscription Group Renewal State, if you have more than one subscription group, you will need more than one.
    public var individualSubscriptionGroupStatus: RenewalState?
    public var familySubscriptionGroupStatus: RenewalState?

    // MARK: Lifecycle
    func initialize() {
        debugPrint("\(StoreKitCoordinator.identifier) initialize \(DebuggingIdentifiers.actionOrEventInProgress) Initializing... \(DebuggingIdentifiers.actionOrEventInProgress)")
        // Start a transaction listener as close to app launch as possible so you don't miss any transactions.
        debugPrint("\(StoreKitCoordinator.identifier) initialize \(DebuggingIdentifiers.actionOrEventInProgress) Starting Transaction Listener... \(DebuggingIdentifiers.actionOrEventInProgress)")
        updateListenerTask = listenForTransactions()

        Task { [weak self] in
            guard let self = self else { return }
            // During store initialization, request products from the App Store.
            debugPrint("\(StoreKitCoordinator.identifier) initialize \(DebuggingIdentifiers.actionOrEventInProgress) Requesting products... \(DebuggingIdentifiers.actionOrEventInProgress)")
            await self.requestProducts()

            // Deliver products that the customer purchases.
            debugPrint("\(StoreKitCoordinator.identifier) initialize \(DebuggingIdentifiers.actionOrEventInProgress) Updating customer product status... \(DebuggingIdentifiers.actionOrEventInProgress)")
            await self.updateCustomerProductStatus()
        }
        debugPrint("\(StoreKitCoordinator.identifier) initialize \(DebuggingIdentifiers.actionOrEventSucceded) initialized")
    }

    deinit {
        debugPrint("\(StoreKitCoordinator.identifier) deinit \(DebuggingIdentifiers.actionOrEventInProgress) Deinitializing... \(DebuggingIdentifiers.actionOrEventInProgress)")
        // Deinitialize configuration
        updateListenerTask?.cancel()
        debugPrint("\(StoreKitCoordinator.identifier) deinit \(DebuggingIdentifiers.actionOrEventSucceded) Deinitialized")
    }

}
