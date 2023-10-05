//
//  PokemonV2Cell+Update.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 10/5/23.
//

import Foundation
import UIKit

extension PokemonV2Cell {
    // This custom function is called when we update the cell from the collectionview.
    func update(header: String, type: String, height: String, weight: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self, let content = LanguageCoordinator.shared.currentContent else { return }
            self.header.attributedText = Styleguide.attributedHeaderStyleText(text: header)
            self.type.attributedText = Styleguide.attributedMetricStyleText(highlight: content.pokemonV2.type, statistic: type)
            self.height.attributedText = Styleguide.attributedMetricStyleText(highlight: content.pokemonV2.height, statistic: height)
            self.weight.attributedText = Styleguide.attributedMetricStyleText(highlight: content.pokemonV2.weight, statistic: weight)
        }
    }
}
