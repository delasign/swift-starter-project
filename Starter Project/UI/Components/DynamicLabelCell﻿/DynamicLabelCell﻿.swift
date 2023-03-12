//
//  DynamicLabelCell﻿.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 3/12/23.
//

import Foundation
import UIKit

class DynamicLabelCell﻿: UICollectionViewCell {
    // MARK: Variables
    static var identifier: String = "DynamicLabelCell﻿"
    // MARK: UI
    let labelI: UILabel = Styleguide.createAttributedStyle()
    let labelII: UILabel = Styleguide.createAttributedStyle()
    let labelIII: UILabel = Styleguide.createAttributedStyle()

    // MARK: Lifecycle
    // This is the function that gets called when you initialize your view.
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Styleguide.colors.black
        self.layer.cornerRadius = kPadding
        self.setupUI()
    }

    // This function is required for a custom UIView.
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // viewWillTransition should be called when the view resizes or changes orientation.
    override func willTransition(from oldLayout: UICollectionViewLayout, to newLayout: UICollectionViewLayout) {
        super.willTransition(from: oldLayout, to: newLayout)
    }

    // This is the function that gets called when your UICollectionViewCell gets reused.
    // This is where you should remove any views that aren't constant, as well as deallocate data, images or text.
    override func prepareForReuse() {
        super.prepareForReuse()
        self.labelI.text = ""
        self.labelII.text = ""
        self.labelIII.text = ""
    }
}
