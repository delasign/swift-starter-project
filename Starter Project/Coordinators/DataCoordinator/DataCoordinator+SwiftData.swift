//
//  DataCoordinator+SwiftData.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 9/11/23.
//

import Foundation
import SwiftData

extension DataCoordinator {
    func getAllObjects() -> [SampleSwiftDataModel] {
        do {
            let data = try persistantContainer.mainContext.fetch(FetchDescriptor<SampleSwiftDataModel>())
                debugPrint("\(DataCoordinator.identifier) \(DebuggingIdentifiers.actionOrEventSucceded) getAllObjects : \(data)")
                return data
        } catch {
            debugPrint("\(DataCoordinator.identifier) \(DebuggingIdentifiers.actionOrEventSucceded) getAllObjects : data is nil")
            return []
        }
    }
}
