//
//  DynamicLabelCell﻿+Update.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 3/12/23.
//

import Foundation
import UIKit
import TinyConstraints

extension DynamicLabelCell﻿ {
    // Update the cell to match the incoming text.
    // Label II and III might be empty based on the algorithm that is passed through the UICollectionViewCell.
    func update(labelI: String, labelII: String, labelIII: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.labelI.attributedText = Styleguide.attributedText(text: labelI)
            self.labelI.sizeToFit()
            self.labelII.attributedText = Styleguide.attributedText(text: labelII)
            self.labelII.sizeToFit()
            self.labelIII.attributedText = Styleguide.attributedText(text: labelIII)
            self.labelIII.sizeToFit()
        }
    }
}
