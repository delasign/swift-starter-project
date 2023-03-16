//
//  Offering+Notifications.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 3/8/23.
//

import Foundation
import UIKit

extension Offering {
    // The setupNotifications function should be the only publically available class in this extension.
    func setupNotifications() {
        //        NotificationCenter.default.addObserver(self, selector: #selector(self.reloadData), name: SystemNotifications.onContentUpdate, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.reloadData), name: SystemNotifications.onStoreKitUpdate, object: nil)
    }
    // MARK: Notification Setup Functionality
    @objc private func reloadData() {
        debugPrint("\(Offering.identifier) reloadData \(DebuggingIdentifiers.notificationRecieved) Recieved On Content Update or On StoreKit Update.")
        self.setDataSourceData()
        DispatchQueue.main.async {
            //            self.tableView.reloadData()
            self.collectionView.reloadData()
            self.collectionView.collectionViewLayout.invalidateLayout()
        }
    }
}
