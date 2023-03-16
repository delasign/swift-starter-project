//
//  SectionTitleCell+Update.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 3/14/23.
//

import Foundation
import UIKit

extension SectionTitleCell {
    func update(text: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.title.attributedText = Styleguide.attributedSectionTitleText(text: text)
            self.title.sizeToFit()
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
    }
}
