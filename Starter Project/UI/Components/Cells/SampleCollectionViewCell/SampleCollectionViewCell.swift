//
//  SampleCollectionViewCell.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 11/2/23.
//

import Foundation
import UIKit
import StoreKit

class SampleCollectionViewCell: UICollectionViewCell {
    // MARK: Variables
    static var identifier: String = "SampleCollectionViewCell"
    // MARK: Lifecycle
    // This is the function that gets called when you initialize your view.
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Styleguide.getPrimaryColor()
    }

    // This function is required for a custom UIView.
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // This is the function that gets called when your UICollectionViewCell gets reused.
    // This is where you should remove any views that aren't constant, as well as deallocate data, images or text.
    override func prepareForReuse() {
        super.prepareForReuse()
        DispatchQueue.main.async { [weak self] in
            guard let _ = self else { return }
        }
    }
}

