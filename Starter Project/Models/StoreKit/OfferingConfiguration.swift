//
//  OfferingConfiguration.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 2/22/23.
//

import Foundation

class OfferingConfiguration: NSObject {

    // MARK: Variables
    // An identifier for debugging purposes
    static let identifier: String = "[OfferingConfiguration]"
    // A dictionary to hold the offering plist
    var offering: [String: String]?
    // A private variable to know what plist to target.
    private let plistName = "Offering.plist"

    // MARK: Lifecycle

    override init() {
        super.init()
        debugPrint("\(OfferingConfiguration.identifier) initialize \(DebuggingIdentifiers.actionOrEventInProgress) Initializing... \(DebuggingIdentifiers.actionOrEventInProgress)")
        if let offering = getOffering() {
            self.offering = offering
            debugPrint("\(OfferingConfiguration.identifier) initialize \(DebuggingIdentifiers.actionOrEventSucceded) Succesfully initialized.")
        } else {
            debugPrint("\(OfferingConfiguration.identifier) initialize \(DebuggingIdentifiers.actionOrEventFailed) Failed to initialize.")
        }
    }

    // MARK: Get Plist

    private func getOffering() -> [String: String]? {
        debugPrint("\(OfferingConfiguration.identifier) getOffering \(DebuggingIdentifiers.actionOrEventInProgress) Gathering Offering... \(DebuggingIdentifiers.actionOrEventInProgress)")
        guard let path = Bundle.main.path(forResource: plistName, ofType: "") else { return nil }
        let url = URL(fileURLWithPath: path)

        if let data = try? Data(contentsOf: url), let plist = try! PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil) as? [String: String] {
            debugPrint("\(Configuration.identifier) getOffering \(DebuggingIdentifiers.actionOrEventSucceded) with plist \(plist) ")

            return plist
        } else {
            debugPrint("\(Configuration.identifier) getOffering \(DebuggingIdentifiers.actionOrEventFailed). Could not gather plist.")
            return nil
        }
    }

    // MARK: Utilities

    func getOfferingIdForKey(key: OfferingKeys.RawValue) -> String? {
        guard let offering = self.offering, let value = offering[key] else {
            debugPrint("\(Configuration.identifier) getOfferingIdForKey \(DebuggingIdentifiers.actionOrEventFailed). Failed to get string for key \(key).")
            return nil
        }
        debugPrint("\(Configuration.identifier) getOfferingIdForKey \(DebuggingIdentifiers.actionOrEventSucceded). Gathered string - \(value) - for key \(key).")
        return value
    }
}
