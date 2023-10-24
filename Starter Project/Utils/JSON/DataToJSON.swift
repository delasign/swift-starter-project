//
//  DataToJSON.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 10/24/23.
//

import Foundation

func convertDataToJSON<T: Decodable>(_: T.Type, data: Data) -> T? {
    do {
        let decodedJSON = try JSONDecoder().decode(T.self, from: data)
        debugPrint("convertDataToJSON \(DebuggingIdentifiers.actionOrEventSucceded) decodedJSON : \(decodedJSON)")
        return decodedJSON
    } catch {
        debugPrint("convertDataToJSON \(DebuggingIdentifiers.actionOrEventFailed) error : \(error)")
        return nil
    }
}
