//
//  ProgressIndicator+Notifications.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 10/31/23.
//

import Foundation
import UIKit

extension ProgressIndicator {
    func setupNotifications() {
        // Foreground
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(willEnterForeground),
            name: UIApplication.willEnterForegroundNotification,
            object: nil
        )
        // Background
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(willResignActive),
            name: UIApplication.willResignActiveNotification,
            object: nil
        )
    }

    // MARK: Foreground / Background
    @objc private func willEnterForeground() {
        animationIsActive = true
        animateTillCompletion = false
        animateBorder()
    }

    @objc private func willResignActive() {
        animationIsActive = false
        animateTillCompletion = false
        reset()
    }
}
