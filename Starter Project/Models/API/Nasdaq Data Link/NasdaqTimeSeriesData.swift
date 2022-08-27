//
//  NasdaqTimeSeriesData.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 8/27/22.
//

import Foundation

struct NasdaqTimeSeriesData: Codable {
    let dataset_data: NasdaqTimeSeriesDataSet
    // Declare the dataset
    struct NasdaqTimeSeriesDataSet: Codable {
        // Could be an int or null, so its an optional
        let limit: Int?
        // Could be an string or null, so its an optional
        let transform: String?
        // Could be an int or null, so its an optional
        let column_index: Int?
        let column_names: [String]
        let start_date: String
        let end_date: String
        let frequency: String
        // Please note these are either strings or floats - so we created the StringOrIntDataType.
        let data: [[StringOrFloatDataType]]
        // Could be an string or null, so its an optional
        let collapse: String?
        // Could be an string or null, so its an optional
        let order: String?
    }
    //
    enum StringOrFloatDataType: Codable {
        case float(Float)
        case string(String)

        init(from decoder: Decoder) throws {
            // Gather the container
            let container = try decoder.singleValueContainer()

            if let float = try? container.decode(Float.self) {
                self = .float(float)
                return
            }

            if let string = try? container.decode(String.self) {
                self = .string(string)
                return
            }

            throw DecodingError.typeMismatch(StringOrFloatDataType.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Encoded payload not of an expected type"))
        }
    }
}
