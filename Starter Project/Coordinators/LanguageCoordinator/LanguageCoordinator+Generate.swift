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

            if let languageContent = gatherLanguageContent(langugeCode: language.value) {
                languageContentPackage.append([language.key: languageContent])
            }
        }
        self.languageContent = languageContentPackage
        debugPrint("\(LanguageCoordinator.identifier) generateLanguageContent \(DebuggingIdentifiers.actionOrEventSucceded) Gathered Content")
    }

    private func gatherLanguageContent(langugeCode: String) -> UIContent? {
        debugPrint("\(LanguageCoordinator.identifier) gatherLanguageContent \(DebuggingIdentifiers.actionOrEventInProgress) Generating Content for : \(langugeCode)")

        guard let languageJSON = Bundle.main.path(forResource: langugeCode, ofType: "json") else {
            debugPrint("\(LanguageCoordinator.identifier) gatherLanguageContent \(DebuggingIdentifiers.actionOrEventFailed) Failed to gather Content: path does nto exist")
            return nil
        }

        do {
            let jsondata = try Data(contentsOf: URL(fileURLWithPath: languageJSON), options: .mappedIfSafe)
            let data = try JSONDecoder().decode(UIContent.self, from: jsondata)
            debugPrint("\(LanguageCoordinator.identifier) gatherLanguageContent \(DebuggingIdentifiers.actionOrEventSucceded) Generated Content for : \(langugeCode)")
            return data

        } catch {
            debugPrint("\(LanguageCoordinator.identifier) gatherLanguageContent \(DebuggingIdentifiers.actionOrEventFailed) Failed to gather Content for : \(langugeCode)")
            return nil
        }

    }
}
