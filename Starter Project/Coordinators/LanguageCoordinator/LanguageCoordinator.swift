//
//  LanguageCoordinator.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 7/12/22.
//

import Foundation

class LanguageCoordinator: NSObject {
    static let identifier: String = "[LanguageCoordinator]"
    static let shared: LanguageCoordinator = LanguageCoordinator()

    func initialize() {
        debugPrint("\(LanguageCoordinator.identifier) \(DebuggingIdentifiers.actionOrEventInProgress) Initializing.")
        // Carry out your code.
        debugPrint("\(LanguageCoordinator.identifier) \(DebuggingIdentifiers.actionOrEventSucceded) Initialized.")
    }
}
