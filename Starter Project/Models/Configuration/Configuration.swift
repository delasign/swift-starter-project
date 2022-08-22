//
//  Configuration.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 8/21/22.
//

import Foundation

class Configuration: NSObject {

    // MARK: Variables
    // An identifier for debugging purposes
    static let identifier: String = "[Configuration]"
    // A dictionary to hold the plist
    private var dictionary: [String: Any] = [String: Any]()
    // A private variable to know what plist to target.
    private let plistName = "Configuration.plist"

    // MARK: Lifecycle

    func initialize() {
        if let plist = getPlist() {
            self.dictionary = plist
            debugPrint("\(Configuration.identifier) initialize \(DebuggingIdentifiers.actionOrEventSucceded) Succesfully initialized.")
        } else {
            debugPrint("\(Configuration.identifier) initialize \(DebuggingIdentifiers.actionOrEventFailed) Failed to initialize.")
        }
    }

    // MARK: Get Plist

    private func getPlist() -> [String: String]? {
        debugPrint("\(Configuration.identifier) \(DebuggingIdentifiers.actionOrEventSucceded) Gathered Plist.")
        guard let path = Bundle.main.path(forResource: plistName, ofType: "") else { return nil }
        let url = URL(fileURLWithPath: path)

        if let data = try? Data(contentsOf: url), let plist = try! PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil) as? [String: String] {
            debugPrint("\(Configuration.identifier) getPlist \(DebuggingIdentifiers.actionOrEventSucceded) with plist \(plist) ")

            return plist
        } else {
            debugPrint("\(Configuration.identifier) getPlist \(DebuggingIdentifiers.actionOrEventFailed). Could not gather plist.")
            return nil
        }
    }

    // MARK: Utilities

    func getStringForKey(key: String) -> String? {
        guard let value = self.dictionary[key] as? String else {
            debugPrint("\(Configuration.identifier) getStringForKey \(DebuggingIdentifiers.actionOrEventFailed). Failed to get string for key \(key).")
            return nil
        }
        debugPrint("\(Configuration.identifier) getStringForKey \(DebuggingIdentifiers.actionOrEventSucceded). Gathered string - \(value) - for key \(key).")
        return value
    }

    func getBooleanForKey(key: String) -> Bool? {
        guard let value = self.dictionary[key] as? Bool else {
            debugPrint("\(Configuration.identifier) getBooleanForKey \(DebuggingIdentifiers.actionOrEventFailed). Failed to get boolean for key \(key).")
            return nil
        }
        debugPrint("\(Configuration.identifier) getBooleanForKey \(DebuggingIdentifiers.actionOrEventSucceded). Gathered boolean - \(value) - key \(key).")
        return value
    }
}
