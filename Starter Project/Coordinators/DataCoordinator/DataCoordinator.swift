//
//  DataCoordinator.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 8/21/22.
//

import Foundation
import UIKit
import SwiftData

@MainActor
class DataCoordinator: NSObject {

    // MARK: Variables
    static let identifier: String = "[DataCoordinator]"
    static let shared: DataCoordinator = DataCoordinator()
    let configuration: Configuration = Configuration()
    // Experience initializes in the Custom State
    var experienceState: ExperienceStates = .custom
    // MARK: Swift Data
    // SwiftData Persistant Container
    let persistantContainer: ModelContainer = {
        do {
            let container = try ModelContainer(
                for: SampleSwiftDataModel.self,
                configurations: ModelConfiguration()
            )
            return container
        } catch {
            fatalError("Failed to create a container")
        }
    }()
    var sampleSwiftDataModels: [SampleSwiftDataModel] = [] {
        didSet {
            NotificationCoordinator.shared.sendOnUpdatedData()
        }
    }
    // MARK: Lifecycle
    func initialize() {
        debugPrint("\(DataCoordinator.identifier) initialize \(DebuggingIdentifiers.actionOrEventInProgress) Initializing... \(DebuggingIdentifiers.actionOrEventInProgress)")
        // Intialize configuration
        self.configuration.initialize()
        // Get All SwiftData Objects
        self.syncObjects()
    }
}
