//
//  LanguageCoordinator+SetCurrentLanguage.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 7/13/22.
//

import Foundation
import UIKit

extension LanguageCoordinator {
    public func determineCurrentLanguage(completionHandler: @escaping (() -> Void)) {
        guard let languageCode = Locale.preferredLanguages.first?.prefix(2) else {
            debugPrint("\(LanguageCoordinator.identifier) determineCurrentLanguage \(DebuggingIdentifiers.actionOrEventFailed) Failed to find current language.")
            return
        }

        debugPrint("\(LanguageCoordinator.identifier) determineCurrentLanguage \(DebuggingIdentifiers.actionOrEventSucceded) Found current language code : ", languageCode)

        let newLanguage: Language

        switch languageCode {
// US Spanish, Spanish, Catalan and Basque reset to spanish
        case "es", "eu", "ca", "es-US":
            newLanguage = .spanish
            default:
            newLanguage = .english
        }

        self.currentLanguage = newLanguage
        completionHandler()
    }
}
