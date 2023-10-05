//
//  DataCoordinator.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 8/21/22.
//

import Foundation
import UIKit
import Apollo

@MainActor
class DataCoordinator: NSObject {

    // MARK: Variables
    static let identifier: String = "[DataCoordinator]"
    static let shared: DataCoordinator = DataCoordinator()
    let configuration: Configuration = Configuration()
    // Experience initializes in the Custom State
    var experienceState: ExperienceStates = .custom
    // Apollo
    var apolloClient: ApolloClient?

    // MARK: Lifecycle
    func initialize() {
        debugPrint("\(DataCoordinator.identifier) initialize \(DebuggingIdentifiers.actionOrEventInProgress) Initializing... \(DebuggingIdentifiers.actionOrEventInProgress)")
        // Intialize configuration
        self.configuration.initialize()
        // Setup Apollo
        if let baseUrl = self.configuration.getBaseURL(), let url = URL(string: baseUrl) {
            // Initialize the client
            self.apolloClient = ApolloClient(url: url)
            debugPrint("\(DataCoordinator.identifier) initialize \(DebuggingIdentifiers.actionOrEventSucceded) Successfully initialized the Apollo Client.")
            // Make the API call
            makePokemonGraphQLCall()

        } else {
            debugPrint("\(DataCoordinator.identifier) initialize \(DebuggingIdentifiers.actionOrEventFailed) Failed to initialize the Apollo Client.")
        }
    }
}
