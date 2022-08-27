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
    var nasdaqDataLinkClient: APIClient?

    // MARK: Lifecycle
    func initialize() {
        debugPrint("\(DataCoordinator.identifier) initialize \(DebuggingIdentifiers.actionOrEventInProgress) Initializing... \(DebuggingIdentifiers.actionOrEventInProgress)")
        // Intialize configuration
        self.configuration.initialize()
        if let apiKey = self.configuration.getAPIKey(), let baseURL = self.configuration.getBaseURL() {
            let apiConfiguration: APIConfiguration = APIConfiguration(apiKey: apiKey, url: URL(string: baseURL))
            self.nasdaqDataLinkClient = APIClient(configuration: apiConfiguration)
            debugPrint("\(DataCoordinator.identifier) initialize \(DebuggingIdentifiers.actionOrEventSucceded) Initialized Nasdaq Data Link API Client with configuration : \(apiConfiguration).")
            // Make sample call
            self.getNasdaqDataLinkTimeSeries()
        } else {
            debugPrint("\(DataCoordinator.identifier) initialize \(DebuggingIdentifiers.actionOrEventFailed) Failed to initialize Nasdaq Data Link API Client.")
        }
    }
}
