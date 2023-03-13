//
//  SectionBCell+Update.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 3/13/23.
//

import Foundation
import UIKit

extension SectionBCell {
    // This custom function is called when we update the cell from the collectionview.
    func update(image: String, title: String, body: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.imageView.image = UIImage(named: image)
            self.titleLabel.attributedText = Styleguide.attributedCellTitleText(text: title)
            self.titleLabel.sizeToFit()
            self.bodyLabel.attributedText = Styleguide.attributedCellBodyText(text: body)
            self.bodyLabel.sizeToFit()
        }
    }
}
