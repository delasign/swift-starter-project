//
//  Offering+CollectionView.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 3/8/23.
//

import Foundation
import UIKit

extension Offering: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    // MARK: Number of Sections & Items
    /*
     This function determines the number of sections in your collectionview.
     It's not required & it defaults to 1.
     */
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // There is only one section in this tutorial
        return OfferingSections.allCases.count
    }
    /*
     This function determines the number of items in your collectionview.
     It's required and there is no default.
     */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // In this tutorial, we will want to use the DataCoordinator PokemonV2Data count.
        switch OfferingSections.allCases[section] {
        case .consumables:
            return StoreKitCoordinator.shared.consumables.count
        case .nonConsumables:
            return StoreKitCoordinator.shared.nonConsumables.count
        case .nonRenewingSubscriptions:
            return StoreKitCoordinator.shared.nonRenewables.count
        case .autoRenewableSubscriptions:
            return StoreKitCoordinator.shared.subscriptions.count
        case .offerCodesAndRefunds:
            return 0
        case .restorePurchases:
            return 0
        }
    }

    // MARK: Cell
    /*
     This function gets called everytime a cell needs to be rendered.
     When the cell gets 'reused' it will first call 'prepareForReuse' - which is where you should clear your cell.
     Once it's reused, in this function, you can call functionality to tweak it to your desired visual.
     */
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Get the Cell
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductTile.identifier, for: indexPath) as? ProductTile else {
            return UICollectionViewCell()
        }

        switch OfferingSections.allCases[indexPath.section] {
        case .consumables:
            cell.setup(type: .price, product: StoreKitCoordinator.shared.consumables[indexPath.row])
            break
        case .nonConsumables:
            cell.setup(type: .price, product: StoreKitCoordinator.shared.nonConsumables[indexPath.row])
            break
        case .nonRenewingSubscriptions:
            cell.setup(type: .price, product: StoreKitCoordinator.shared.nonRenewables[indexPath.row])
            break
        case .autoRenewableSubscriptions:
            cell.setup(type: .price, product: StoreKitCoordinator.shared.subscriptions[indexPath.row])
            break
        case .offerCodesAndRefunds:
            break
        case .restorePurchases:
            break
        }
        // Update the cell to match the data gathered from the GraphQL at this index
        //        let pokemonData = DataCoordinator.shared.pokemonV2Data[indexPath.row]
        //        if let type = pokemonData.pokemonV2Pokemontypes.first?.pokemonV2Type?.name,
        //           let height = pokemonData.height,
        //           let weight = pokemonData.weight {
        //            debugPrint("\(CustomUIView.identifier) cellForItemAt \(DebuggingIdentifiers.actionOrEventSucceded) Succefully gathered data for indexpath \(indexPath.row).")
        //            cell.update(header: pokemonData.name, type: type, height: "\(height)", weight: "\(weight)")
        //        } else {
        //            debugPrint("\(CustomUIView.identifier) cellForItemAt \(DebuggingIdentifiers.actionOrEventFailed) Failed to update cell as we could not gather the data.")
        //        }

        // Return the cell
        return cell
    }

    // MARK: Visual Parameters
    /*
     This function determines the size of the cell for each given indexPath (i.e. section and row).
     */
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Determine the frame
        let collectionViewFrame: CGRect = collectionView.frame

        //        switch OfferingSections.allCases[indexPath.section] {
        //        case .consumables:
        //            break
        //        case .nonConsumables:
        //            break
        //        case .nonRenewingSubscriptions:
        //            break
        //        case .autoRenewableSubscriptions:
        //            break
        //        case .offerCodesAndRefunds:
        //            break
        //        case .restorePurchases:
        //            break
        //        }

        // Return the size
        return CGSize(width: collectionViewFrame.width, height: 200)
    }

    /*
     This function determines the insets (also known as padding) for the collectionview.
     */
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(
            top: 130,
            left: 0,
            bottom: kPadding,
            right: 0
        )
    }

    /*
     This function determines the spacing between items within a section.
     */

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return kPadding
    }

    /*
     This function determines the spacing between sections.
     */

    func collectionView(_ collectionView: UICollectionView, layout
                            collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {

        return kPadding
    }
}
