//
//  Refund+Notifications.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 3/8/23.
//

import Foundation
import UIKit

extension Refund {
    // The setupNotifications function should be the only publically available class in this extension.
    func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.reloadData), name: SystemNotifications.onContentUpdate, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.reloadData), name: SystemNotifications.onStoreKitUpdate, object: nil)
    }
    // MARK: Notification Setup Functionality
    @objc private func reloadData() {
        guard let currentContent = LanguageCoordinator.shared.currentContent else { return }
        debugPrint("\(Refund.identifier) reloadData \(DebuggingIdentifiers.notificationRecieved) Recieved On Content Update or On StoreKit Update.")

        let skc = StoreKitCoordinator.shared
        DispatchQueue.main.async {
            // Hide / Show UICollectionView or Label + Reload Data
            if skc.purchasedConsumables.isEmpty && skc.purchasedNonConsumables.isEmpty && skc.purchasedNonRenewables.isEmpty && skc.purchasedIndividualSubscriptions.isEmpty && skc.purchasedFamilySubscriptions.isEmpty {
                self.collectionView.isHidden = true
                self.noRefundsAvailableLabel.attributedText = Styleguide.attributedLabelText(text: currentContent.refund.noRefundsAvailable, color: Styleguide.colors.black)
                self.noRefundsAvailableLabel.isHidden = false
            } else {
                self.collectionView.isHidden = false
                self.noRefundsAvailableLabel.isHidden = true

                self.collectionView.collectionViewLayout.invalidateLayout()
                self.setDataSourceData()
            }

        }
    }
}
