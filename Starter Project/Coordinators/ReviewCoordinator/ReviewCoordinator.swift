//
//  ReviewCoordinator.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 5/12/23.
//

import Foundation
import UIKit
import StoreKit

class ReviewCoordinator: NSObject {

    static let shared = ReviewCoordinator()
    let identifier = "[ReviewCoordinator] "
    let debug = false

    func initialize() {}

    func requestReview() {
        var lastVersionPromptedForReview = "0"
        if let version = UserDefaults.standard.string(forKey: UserDefaultsKeys.lastVersionPromptedForReviewKey) {
            lastVersionPromptedForReview = version
        }

        // Get the current bundle version for the app
        let infoDictionaryKey = kCFBundleVersionKey as String
        guard let currentVersion = Bundle.main.object(forInfoDictionaryKey: infoDictionaryKey) as? String
        else { fatalError("Expected to find a bundle version in the info dictionary") }

        guard currentVersion != lastVersionPromptedForReview else {
            debugPrint("\(self.identifier) | Already asked to review this version")
            UserDefaults.standard.set(0, forKey: UserDefaultsKeys.processCompletedCountKey)
            return
        }

        //         If the count has not yet been stored, this will return 0
        var count = UserDefaults.standard.integer(forKey: UserDefaultsKeys.processCompletedCountKey)
        count += 1
        UserDefaults.standard.set(count, forKey: UserDefaultsKeys.processCompletedCountKey)

        debugPrint("\(self.identifier) | Process completed \(count) time(s)")

        debugPrint("\(self.identifier) | lastVersionPromptedForReview \(lastVersionPromptedForReview)")

        // Has the process been completed several times and the user has not already been prompted for this version?
        if count >= 4 && currentVersion != lastVersionPromptedForReview {
            debugPrint("\(self.identifier) | valid review request")
            if #available(iOS 13, *) {
                if let scene = UIApplication
                    .shared
                    .connectedScenes
                    .flatMap({ ($0 as? UIWindowScene)?.windows ?? [] }).first?.windowScene {

                    SKStoreReviewController.requestReview(in: scene)
                    UserDefaults.standard.set(currentVersion, forKey: UserDefaultsKeys.lastVersionPromptedForReviewKey)
                    UserDefaults.standard.set(0, forKey: UserDefaultsKeys.processCompletedCountKey)

                }

            } else {
                if let scene = UIApplication.shared.windows.first?.windowScene {
                    SKStoreReviewController.requestReview(in: scene)
                    UserDefaults.standard.set(currentVersion, forKey: UserDefaultsKeys.lastVersionPromptedForReviewKey)
                    UserDefaults.standard.set(0, forKey: UserDefaultsKeys.processCompletedCountKey)
                }
            }

        }
    }
}
