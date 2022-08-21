//
//  APIConfiguration.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 8/21/22.
//

import Foundation

struct APIConfiguration {
    var urlSession: URLSession = .shared
    var apiKey: String
    var url: URL?
}
