//
//  StandardButton+Update.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 9/13/23.
//

import Foundation
import UIKit

extension StandardButton {
    func update(text: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.label.attributedText = Styleguide.attributedText(text: text)
        }
    }
}
