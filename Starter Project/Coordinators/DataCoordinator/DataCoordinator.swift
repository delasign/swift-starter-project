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
    let configuration: Configuration = Configuration()
    // Experience initializes in the Custom State
    var experienceState: ExperienceStates = .custom

    // MARK: Lifecycle
    func initialize() {
        debugPrint("\(DataCoordinator.identifier) initialize \(DebuggingIdentifiers.actionOrEventInProgress) Initializing... \(DebuggingIdentifiers.actionOrEventInProgress)")
        // Intialize configuration
        self.configuration.initialize()
    }
}
