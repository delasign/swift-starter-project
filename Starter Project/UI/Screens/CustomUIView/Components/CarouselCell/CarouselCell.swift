//
//  CarouselCell.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 8/15/22.
//

import Foundation
import UIKit

class CarouselCell: UICollectionViewCell {
    
    // MARK: Variables
    static var identifier: String = "CarouselCell"
    // MARK: UI
    let imageView: UIImageView = UIImageView(image: UIImage(named: SampleImages.placeholder))
    // MARK: Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /*
        This function gets called when a cell gets removed from the collectionview
        and should remove all callbacks or data that could get held in memory.
        
        For example: Set all callbacks & images to nil and set all text to "".
    */
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
