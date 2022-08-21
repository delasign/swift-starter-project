//
//  DataCoordinator.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 8/21/22.
//

import Foundation
import UIKit

class DataCoordinator: NSObject {

    // MARK: Variables
    static let identifier: String = "[DataCoordinator]"
    static let shared: DataCoordinator = DataCoordinator()

    // MARK: Lifecycle

    func initialize() {
        debugPrint("\(LanguageCoordinator.identifier) \(DebuggingIdentifiers.actionOrEventInProgress) Initializing... \(DebuggingIdentifiers.actionOrEventInProgress)")
    }
}
