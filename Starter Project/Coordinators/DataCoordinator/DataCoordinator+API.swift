//
//  DataCoordinator+API.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 8/27/22.
//

import Foundation

extension DataCoordinator {

    func getNasdaqDataLinkTimeSeries() {
        debugPrint("\(DataCoordinator.identifier) getNasdaqDataLinkTimeSeries \(DebuggingIdentifiers.actionOrEventInProgress) Making API Call... \(DebuggingIdentifiers.actionOrEventInProgress)")
        guard let nasdaqDataLinkClient = self.nasdaqDataLinkClient else {
            debugPrint("\(DataCoordinator.identifier) getNasdaqDataLinkTimeSeries \(DebuggingIdentifiers.actionOrEventFailed) Failed to make time series call as the API client is not available.")
            return
        }

        nasdaqDataLinkClient.get(NasdaqTimeSeriesData.self, path: "", parameters: [URLQueryItem(name: "api_key", value: nasdaqDataLinkClient.configuration.apiKey)], requestHeaders: []) { result in
            switch result {
            case let .success(data):
                debugPrint("\(DataCoordinator.identifier) getNasdaqDataLinkTimeSeries \(DebuggingIdentifiers.actionOrEventSucceded) Succeeded to make call.")
                break
            case let .failure(error):
                debugPrint("\(DataCoordinator.identifier) getNasdaqDataLinkTimeSeries \(DebuggingIdentifiers.actionOrEventFailed) Failed to make call with error \(error).")
                break
            }
        }
    }
}
