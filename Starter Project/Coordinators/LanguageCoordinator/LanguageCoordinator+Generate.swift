//
//  LanguageCoordinator+Generate.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 7/13/22.
//

import Foundation
import UIKit

extension LanguageCoordinator {
    func generateLanguageContent(languages: [Language: String]) {
        var languageContentPackage: [[Language: UIContent]] = [[Language: UIContent]]()
        for language in languages {

            if let languageContent = gatherLanguageContent(languageCode: language.value) {
                languageContentPackage.append([language.key: languageContent])
            }
        }
        self.languageContent = languageContentPackage
        debugPrint("\(LanguageCoordinator.identifier) generateLanguageContent \(DebuggingIdentifiers.actionOrEventSucceded) Gathered Content")
    }

    private func gatherLanguageContent(languageCode: String) -> UIContent? {
        debugPrint("\(LanguageCoordinator.identifier) gatherLanguageContent \(DebuggingIdentifiers.actionOrEventInProgress) Generating Content for : \(languageCode)")

        let path: String?
        
        if isTestEnvironment {
            path = Bundle(for: type(of: self)).path(forResource: languageCode, ofType: "json")
        } else {
            path = Bundle.main.path(forResource: languageCode, ofType: "json")
        }
        
        guard let languageJSON = path else {
            debugPrint("\(LanguageCoordinator.identifier) gatherLanguageContent \(DebuggingIdentifiers.actionOrEventFailed) Failed to gather Content: path does nto exist")
            return nil
        }

        do {
            let jsondata = try Data(contentsOf: URL(fileURLWithPath: languageJSON), options: .mappedIfSafe)
            let data = try JSONDecoder().decode(UIContent.self, from: jsondata)
            debugPrint("\(LanguageCoordinator.identifier) gatherLanguageContent \(DebuggingIdentifiers.actionOrEventSucceded) Generated Content for : \(languageCode)")
            return data

        } catch {
            debugPrint("\(LanguageCoordinator.identifier) gatherLanguageContent \(DebuggingIdentifiers.actionOrEventFailed) Failed to gather Content for : \(languageCode)")
            return nil
        }

    }
}
