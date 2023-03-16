//
//  Offering+TableView.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 3/16/23.
//

import Foundation
import UIKit
import StoreKit

// extension Offering: UITableViewDataSource, UITableViewDelegate {
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return Offering.Sections.count
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        switch Offering.Sections[section] {
//        case .consumablesTitle, .nonConsumablesTitle, .nonRenewingSubscriptionsTitle, .autoRenewableSubscriptionsTitle:
//            return 1
//        //        default:
//        //            return 0
//        case .consumables:
//            return StoreKitCoordinator.shared.consumables.count
//        case .nonConsumables:
//            return StoreKitCoordinator.shared.nonConsumables.count
//        case .nonRenewingSubscriptions:
//            return StoreKitCoordinator.shared.nonRenewables.count
//        case .autoRenewableSubscriptionsIndividualPlans:
//            return StoreKitCoordinator.shared.individualSubscriptions.count
//        case .autoRenewableSubscriptionsFamilyPlans:
//            return StoreKitCoordinator.shared.familySubscriptions.count
//        case .offerCodesAndRefunds:
//            return 0
//        case .restorePurchasesTitle:
//            return 0
//        case .restorePurchases:
//            return 0
//        }
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell: UITableViewCell
//        switch Offering.Sections[indexPath.section] {
//        case .consumablesTitle, .nonConsumablesTitle, .nonRenewingSubscriptionsTitle, .autoRenewableSubscriptionsTitle:
//            cell = setupSectionTitleCell(tableView, cellForRowAt: indexPath)
//        case .consumables, .nonConsumables, .nonRenewingSubscriptions, .autoRenewableSubscriptionsIndividualPlans, .autoRenewableSubscriptionsFamilyPlans:
//            cell = setupProductTile(tableView, cellForRowAt: indexPath)
//        case .offerCodesAndRefunds:
//            cell = UITableViewCell()
//        case .restorePurchasesTitle:
//            cell = UITableViewCell()
//        case .restorePurchases:
//            cell = UITableViewCell()
//        }
//
//        //        cell.setNeedsLayout()
//        //        cell.layoutIfNeeded()
//
//        return cell
//    }
//
//    // MARK: Cells
//
//    func setupSectionTitleCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: SectionTitleCell.identifier, for: indexPath) as? SectionTitleCell, let currentContent = LanguageCoordinator.shared.currentContent else {
//            return UITableViewCell()
//        }
//
//        let title: String
//
//        switch Offering.Sections[indexPath.section] {
//        case .consumablesTitle:
//            title = currentContent.shared.consumables
//            break
//        case .nonConsumablesTitle:
//            title = currentContent.shared.nonConsumables
//            break
//        case .nonRenewingSubscriptionsTitle:
//            title = currentContent.shared.nonRenewingSubscriptions
//            break
//        case .autoRenewableSubscriptionsTitle:
//            title = currentContent.shared.autoRenewingSubscriptions
//            break
//        default:
//            title = currentContent.shared.error
//            break
//        }
//
//        cell.update(text: title)
//
//        return cell
//    }
//
//    func setupProductTile(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductTile.identifier, for: indexPath) as? ProductTile else {
//            return UITableViewCell()
//        }
//
//        let product: Product
//
//        switch Offering.Sections[indexPath.section] {
//        case .consumables:
//            product = StoreKitCoordinator.shared.consumables[indexPath.row]
//        case .nonConsumables:
//            product = StoreKitCoordinator.shared.nonConsumables[indexPath.row]
//        case .nonRenewingSubscriptions:
//            product = StoreKitCoordinator.shared.nonRenewables[indexPath.row]
//        case .autoRenewableSubscriptionsIndividualPlans:
//            product = StoreKitCoordinator.shared.individualSubscriptions[indexPath.row]
//        case .autoRenewableSubscriptionsFamilyPlans:
//            product = StoreKitCoordinator.shared.familySubscriptions[indexPath.row]
//        default:
//            return cell
//        }
//
//        cell.configure(type: .price, product: product)
//
//        return cell
//    }
//
// }
