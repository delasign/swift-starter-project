//
//  DataCoordinator+SwiftData.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 9/11/23.
//

import Foundation
import SwiftData

extension DataCoordinator {
    // MARK: Sync
    func syncObjects() {
        sampleSwiftDataModels = getAllObjects()
    }

    // MARK: Get
    func getAllObjects() -> [SampleSwiftDataModel] {
        do {
            // We have chosen to order it by "date" - the creation date - so that the UICollectionView maintains its order as we update the items.
            let data = try persistantContainer.mainContext.fetch(FetchDescriptor<SampleSwiftDataModel>(sortBy: [SortDescriptor(\.date)]))
                debugPrint("\(DataCoordinator.identifier) \(DebuggingIdentifiers.actionOrEventSucceded) getAllObjects : \(data)")
                return data
        } catch {
            debugPrint("\(DataCoordinator.identifier) \(DebuggingIdentifiers.actionOrEventSucceded) getAllObjects : data is nil")
            return []
        }
    }

    func getObject(id: String) -> SampleSwiftDataModel? {
        do {
            var predicate = #Predicate<SampleSwiftDataModel> { object in
                object.id == id
            }
            var descriptor = FetchDescriptor(predicate: predicate)
            descriptor.fetchLimit = 1
            var object = try persistantContainer.mainContext.fetch(descriptor)
            debugPrint("\(DataCoordinator.identifier) \(DebuggingIdentifiers.actionOrEventSucceded) getObject : \(object)")
            return object.first
        } catch {
            debugPrint("\(DataCoordinator.identifier) \(DebuggingIdentifiers.actionOrEventFailed) getObject : \(error)")
            return nil
        }
    }

    func doesObjectExist(id: String) -> Bool {
        return getObject(id: id) != nil
    }

    // MARK: Add
    func addANewObject(id: String, number: Int, boolean: Bool) -> Result<SampleSwiftDataModel, SwiftDataError> {
        // Do not worry about saving, as SwiftData does it for you on UI related triggers.
        // The only cases where you want to save explicitly is if you're sharing the data or sending it over.
        debugPrint("\(DataCoordinator.identifier) \(DebuggingIdentifiers.actionOrEventInProgress) addANewObject \(DebuggingIdentifiers.actionOrEventInProgress)")
        if !doesObjectExist(id: id) {
            // Insert
            let object = SampleSwiftDataModel(id: id, number: number, boolean: boolean, date: Date.now)
            persistantContainer.mainContext.insert(object)
            debugPrint("\(DataCoordinator.identifier) \(DebuggingIdentifiers.actionOrEventSucceded) addANewObject : \(object)")
            // Update DataSet
            syncObjects()
            return .success(object)
        } else {
            debugPrint("\(DataCoordinator.identifier) \(DebuggingIdentifiers.actionOrEventFailed) addANewObject : Object already exists.")
            return .failure(.objectAlreadyExists)
        }
    }

    // MARK: Delete
    func deleteAnObject(id: String) -> Result<Bool, SwiftDataError> {
        // Do not worry about saving, as SwiftData does it for you on UI related triggers.
        // The only cases where you want to save explicitly is if you're sharing the data or sending it over.
        debugPrint("\(DataCoordinator.identifier) \(DebuggingIdentifiers.actionOrEventInProgress) deleteAnObject \(DebuggingIdentifiers.actionOrEventInProgress)")
        if doesObjectExist(id: id), let object = getObject(id: id) {
            // Delete
            persistantContainer.mainContext.delete(object)
            // Update DataSet
            syncObjects()
            debugPrint("\(DataCoordinator.identifier) \(DebuggingIdentifiers.actionOrEventSucceded) deleteAnObject.")
            return .success(true)
        } else {
            debugPrint("\(DataCoordinator.identifier) \(DebuggingIdentifiers.actionOrEventFailed) deleteAnObject: Object doesn't exist. Cannot be deleted.")
            return .failure(.objectDoesntExist)
        }
    }

    func deleteAllObjects() {
        debugPrint("\(DataCoordinator.identifier) \(DebuggingIdentifiers.actionOrEventInProgress) deleteAllObjects \(DebuggingIdentifiers.actionOrEventInProgress)")
        persistantContainer.mainContext.container.deleteAllData()
        debugPrint("\(DataCoordinator.identifier) \(DebuggingIdentifiers.actionOrEventSucceded) deleteAllObjects.")
    }

    // MARK: Update
    // Update is as simple as updating the values on a SwiftData object.
    // Do not worry about saving, as SwiftData does it for you on UI related triggers.
    // The only cases where you want to save explicitly is if you're sharing the data or sending it over.

    func updateObject(id: String, number: Int) -> Result<Bool, SwiftDataError> {
        debugPrint("\(DataCoordinator.identifier) \(DebuggingIdentifiers.actionOrEventInProgress) updateObjectNumber \(DebuggingIdentifiers.actionOrEventInProgress)")
        if let object = getObject(id: id) {
            object.number = number
            // Update DataSet
            syncObjects()
            debugPrint("\(DataCoordinator.identifier) \(DebuggingIdentifiers.actionOrEventSucceded) updateObjectNumber.")
            return .success(true)
        } else {
            debugPrint("\(DataCoordinator.identifier) \(DebuggingIdentifiers.actionOrEventFailed) updateObjectNumber : Object with Id does not exist \(id).")
            return .failure(.objectDoesntExist)
        }
    }

    func updateObject(id: String, boolean: Bool) -> Result<Bool, SwiftDataError> {
        debugPrint("\(DataCoordinator.identifier) \(DebuggingIdentifiers.actionOrEventInProgress) updateObjectBoolean \(DebuggingIdentifiers.actionOrEventInProgress)")
        if let object = getObject(id: id) {
            object.boolean = boolean
            // Update DataSet
            syncObjects()
            debugPrint("\(DataCoordinator.identifier) \(DebuggingIdentifiers.actionOrEventSucceded) updateObjectBoolean.")
            return .success(true)
        } else {
            debugPrint("\(DataCoordinator.identifier) \(DebuggingIdentifiers.actionOrEventFailed) updateObjectBoolean : Object with Id does not exist \(id).")
            return .failure(.objectDoesntExist)
        }
    }
}
