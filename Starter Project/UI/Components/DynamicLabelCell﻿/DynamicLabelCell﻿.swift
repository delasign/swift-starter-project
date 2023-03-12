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
    var labelIITopConstraint: NSLayoutConstraint?
    let labelIII: UILabel = Styleguide.createAttributedStyle()
    var labelIIITopConstraint: NSLayoutConstraint?

    // MARK: Lifecycle
    // This is the function that gets called when you initialize your view.
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Styleguide.colors.white
        self.layer.cornerRadius = kPadding
        self.setupUI()
    }

    override func layoutSubviews() {
        // Shadow
        self.layer.cornerRadius = kPadding
        self.layer.shadowOpacity = 1
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowPath = UIBezierPath(
            roundedRect: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height),
            cornerRadius: kPadding).cgPath
        self.layer.shadowOffset = CGSize(width: 0, height: 5)
        self.layer.shadowOpacity = 0.5
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
        self.labelI.attributedText = nil
        self.labelII.attributedText = nil
        self.labelIII.attributedText = nil
    }
}
