//
//  JSONToData.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 10/24/23.
//
import Foundation

func convertJSONToData<T: Encodable>(item: T) -> Data? {
    do {
        let encodedJSON = try JSONEncoder().encode(item)
        debugPrint("convertJSONToData \(DebuggingIdentifiers.actionOrEventSucceded) data : \(encodedJSON)")
        return encodedJSON
    } catch {
        debugPrint("convertJSONToData \(DebuggingIdentifiers.actionOrEventFailed) error : \(error)")
        return nil
    }
}
