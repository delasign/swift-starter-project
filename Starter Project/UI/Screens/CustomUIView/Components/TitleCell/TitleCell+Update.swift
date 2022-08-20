//
//  TitleCell+Update.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 8/20/22.
//

import Foundation
import UIKit

extension TitleCell {
    // This custom function is called when we update the cell from the collectionview.
    func update(text: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.label.attributedText = Styleguide.attributedHeaderText(text: text)
            self.label.sizeToFit()
        }
    }
}
