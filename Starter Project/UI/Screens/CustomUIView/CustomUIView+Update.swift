//
//  CustomUIView+Update.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 10/05/23.
//

import Foundation
import UIKit
import PokeAPI

extension CustomUIView {
    // MARK: Sample Update Functionality
    // onStateUpdate should be called when changing a view based on its state.
    func onStateUpdate() {

    }

    // updateLayoutConstraints should be called when a view changes orientation or resizes. This function should hold the changes in constraints across breakpoints.
    func updateLayoutConstraints() {
        DispatchQueue.main.async { [weak self] in
            guard let _ = self else { return}
        }
    }

    // onContentUpdate should be called when the LanguageCoordinator updates content.
    func onContentUpdate() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self, let currentContent = LanguageCoordinator.shared.currentContent else {
                debugPrint("\(CustomUIView.identifier) onContentUpdate \(DebuggingIdentifiers.actionOrEventFailed) Failed to update content, either the custom view does not exist or the current content is not available.")
                return
            }
            // Reload CollectionView
            self.collectionView.reloadData()
            // Update the searchbar content
            self.searchBar.onContentUpdate()
            debugPrint("\(CustomUIView.identifier) onContentUpdate \(DebuggingIdentifiers.actionOrEventSucceded) Updated Content!")
        }
    }
    
    // MARK: Filtered Data
    func updateFilteredData() {
        // Determine query
        guard let query = self.searchBar.textField.text else {
            debugPrint("\(CustomUIView.identifier) updateFilteredData \(DebuggingIdentifiers.actionOrEventFailed) Failed to gather query.")
            return
        }
        debugPrint("\(CustomUIView.identifier) updateFilteredData \(DebuggingIdentifiers.actionOrEventSucceded) Gathered Query : \(query)")
        debugPrint("\(CustomUIView.identifier) updateFilteredData \(DebuggingIdentifiers.actionOrEventInProgress) Filtering data \(DebuggingIdentifiers.actionOrEventInProgress)")
        // Declare a variable to capture the new data.
        var newFilteredData: [PokemonGraphQLCallQuery.Data.Pokemon_v2_pokemon] = []
        // Filter through the data and see if there's a match in the name or type.
        for pokemon in DataCoordinator.shared.pokemonV2Data {
            if pokemon.name.localizedLowercase.contains(query.localizedLowercase) {
                newFilteredData.append(pokemon)
            } else if let type = pokemon.pokemon_v2_pokemontypes.first?.pokemon_v2_type?.name, type.localizedLowercase.contains(query.localizedLowercase) {
                newFilteredData.append(pokemon)
            }
        }
        // Update the filtered data
        self.filteredData = newFilteredData
        // Reload CollectionView to display new data
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.collectionView.reloadData()
        }
        debugPrint("\(CustomUIView.identifier) updateFilteredData \(DebuggingIdentifiers.actionOrEventSucceded) Filtering Complete!")
    }

}
