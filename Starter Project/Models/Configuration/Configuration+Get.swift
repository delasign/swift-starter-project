//
//  Configuration+Get.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 8/21/22.
//

import Foundation
import UIKit

extension Configuration {
    // Get Environment Key
    func getEnvironmentKey() -> String? {
        return getStringForKey(key: ConfigurationKeys.environment)
    }

    // Get Base URL
    func getBaseURL() -> String? {
        return getStringForKey(key: ConfigurationKeys.baseURL)
    }

    // Get API Key
    func getAPIKey() -> String? {
        return getStringForKey(key: ConfigurationKeys.apiKey)
    }
}
