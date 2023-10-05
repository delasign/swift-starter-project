//
//  CustomUIView+Notifications.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 7/18/22.
//

import Foundation
import UIKit
extension CustomUIView {
    // The setupNotifications function should be the only publically available class in this extension.
    func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.onSystemUpdatedContent), name: SystemNotifications.onContentUpdate, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.onPokemonV2DataWasUpdated), name: SystemNotifications.onPokemonV2DataWasUpdated, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.onSearchQueryWasUpdated), name: SystemNotifications.onSearchQueryWasUpdated, object: nil)
    }
    // MARK: Notification Setup Functionality
    @objc private func onSystemUpdatedContent(notification: Notification) {
        guard let userInfo = notification.userInfo, let customVariable = userInfo["customVariable"] as? String else {
            debugPrint("\(CustomUIView.identifier) onSystemUpdatedContent \(DebuggingIdentifiers.actionOrEventFailed) Failed to recieve notification as no userInfo exists.")
            return
        }
        debugPrint("\(CustomUIView.identifier) onSystemUpdatedContent \(DebuggingIdentifiers.notificationRecieved) Recieved On Content Update with custom notification variable : \(customVariable)")
        self.onContentUpdate()
    }

    @objc private func onPokemonV2DataWasUpdated(notification: Notification) {
        debugPrint("\(CustomUIView.identifier) onPokemonV2DataWasUpdated \(DebuggingIdentifiers.notificationRecieved).")
        // Reload Data
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.collectionView.reloadData()
        }
    }
    
    @objc private func onSearchQueryWasUpdated(notification: Notification) {
        debugPrint("\(CustomUIView.identifier) onSearchQueryWasUpdated \(DebuggingIdentifiers.notificationRecieved).")
        self.updateFilteredData()
    }
}
