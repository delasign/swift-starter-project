//
//  NasdaqTimeSeriesData.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 8/27/22.
//

import Foundation

struct NasdaqTimeSeriesData: Codable {
    let dataset: NasdaqTimeSeriesDataSet
    // Declare the dataset
    struct NasdaqTimeSeriesDataSet: Codable {
        let limit: Int
        let transform: String
        let column_index: Int
        let column_names: [String]
        let start_date: String
        let end_date: String
        let frequency: String
        // Please note these are either strings or floats but can be interpretted as strings.
        let data: [[String]]
        let collapse: String
        let order: String
    }
}
