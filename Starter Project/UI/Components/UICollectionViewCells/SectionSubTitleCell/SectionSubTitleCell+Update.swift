//
//  SectionSubTitleCell+Update.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 3/15/23.
//

import Foundation
import UIKit

extension SectionSubTitleCell {
    func update(text: String) {
        self.title.attributedText = Styleguide.attributedProductTitleText(text: text)
        self.title.sizeToFit()
    }
}
