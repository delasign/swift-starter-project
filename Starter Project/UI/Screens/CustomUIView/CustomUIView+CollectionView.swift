//
//  CustomUIView+CollectionView.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 10/5/23.
//

import Foundation
import UIKit

extension CustomUIView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    // MARK: Number of Sections & Items
    /*
        This function determines the number of sections in your collectionview.
        It's not required & it defaults to 1.
     */
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // There is only one section in this tutorial
        return 1
    }
    /*
        This function determines the number of items in your collectionview.
        It's required and there is no default.
     */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // In this tutorial, we will want to use the DataCoordinator PokemonV2Data count.
        return DataCoordinator.shared.pokemonV2Data.count
    }
    
    // MARK: Cell
    /*
        This function gets called everytime a cell needs to be rendered.
        When the cell gets 'reused' it will first call 'prepareForReuse' - which is where you should clear your cell.
        Once it's reused, in this function, you can call functionality to tweak it to your desired visual.
     */
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Get the Cell
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonV2Cell.identifier, for: indexPath) as? PokemonV2Cell else {
            return UICollectionViewCell()
        }
        // Update the cell to match the data gathered from the GraphQL at this index
        let pokemonData = DataCoordinator.shared.pokemonV2Data[indexPath.row]
        if let type = pokemonData.pokemon_v2_pokemontypes.first?.pokemon_v2_type?.name,
           let height = pokemonData.height,
           let weight = pokemonData.weight {
            debugPrint("\(CustomUIView.identifier) cellForItemAt \(DebuggingIdentifiers.actionOrEventSucceded) Succefully gathered data for indexpath \(indexPath.row).")
            cell.update(header: pokemonData.name, type: type, height: "\(height)", weight: "\(weight)")
        } else {
            debugPrint("\(CustomUIView.identifier) cellForItemAt \(DebuggingIdentifiers.actionOrEventFailed) Failed to update cell as we could not gather the data.")
        }
        
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
        // Return the size
        return CGSize(width: collectionViewFrame.width, height: self.collectionViewCellHeight)
    }

    /*
     This function determines the insets (also known as padding) for the collectionview.
     */
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(
            top: 0,
            left: 0,
            bottom: 0,
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
