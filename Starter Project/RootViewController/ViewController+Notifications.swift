//
//  ViewController+Notifications.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 3/22/23.
//

import Foundation
import UIKit

extension ViewController {
    // The setupNotifications function should be the only publically available class in this extension.
    func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.onReturnToForeGround), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    // MARK: Notification Setup Functionality
    @objc private func onReturnToForeGround() {
        // Update StoreKit statuses every time the app returns to the foreground
        Task {
            await StoreKitCoordinator.shared.updateCustomerProductStatus()
        }
    }
}
