//
//  LanguageCoordinator.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 7/12/22.
//

import Foundation

class LanguageCoordinator: NSObject {

    // MARK: Variables
    static let identifier: String = "[LanguageCoordinator]"
    static let shared: LanguageCoordinator = LanguageCoordinator()
    static let contentPrefix = "ui_content_"

    let isTestEnvironment: Bool

    var currentLanguage: Language = .english {
        didSet {
            if availableLanguages.keys.contains(currentLanguage) {
                debugPrint("\(LanguageCoordinator.identifier) currentLanguage \(DebuggingIdentifiers.actionOrEventSucceded) Valid language : \(currentLanguage)")
            } else {
                debugPrint("\(LanguageCoordinator.identifier) currentLanguage \(DebuggingIdentifiers.actionOrEventFailed) Invalid language : \(currentLanguage), resetting to english")
                currentLanguage = .english
            }
        }
    }

    var currentContent: UIContent? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                NotificationCoordinator.shared.sendOnContentUpdate()
            }
        }
    }

    private let availableLanguages: [Language: String] = [
        .english: "en",
        .spanish: "es"
    ]

    var languageContent: [[Language: UIContent]] = [[Language: UIContent]]() {
        didSet {
            languageContent.forEach { (item) in
                if let key = item.first?.key,
                   let value = item.first?.value,
                   key == self.currentLanguage {
                    debugPrint("\(LanguageCoordinator.identifier) languageContent \(DebuggingIdentifiers.actionOrEventSucceded) Updated Language Content to : \(key)")
                    self.currentContent = value
                }
            }
        }
    }

    // MARK: Lifecycle

    init(languageCode: String? = nil, isTestEnvironment: Bool? = false) {
        debugPrint("\(LanguageCoordinator.identifier) initialize \(DebuggingIdentifiers.actionOrEventInProgress) Initializing.")
        // Generate Languages
        self.isTestEnvironment = isTestEnvironment ?? false

        super.init()

        self.determineCurrentLanguage { [weak self] in
            guard let self = self else { return }
            self.generateLanguageContent(languages: self.availableLanguages)
            debugPrint("\(LanguageCoordinator.identifier) initialize \(DebuggingIdentifiers.actionOrEventSucceded) Initialized.")
        }

    }
}
