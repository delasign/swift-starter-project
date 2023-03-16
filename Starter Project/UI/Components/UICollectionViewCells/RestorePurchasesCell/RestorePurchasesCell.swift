//
//  RestorePurchasesCell.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 3/16/23.
//

import Foundation
import UIKit

class RestorePurchasesCell: UICollectionViewCell {
    // MARK: Variables
    static var identifier: String = "RestorePurchasesCell"
    var type: ProductTileType = .get
    // MARK: UI
    let button: Button = Button(type: .primary)
    // MARK: Callbacks
    var onRelease: (() -> Void)?

    // MARK: Lifecycle
    // This is the function that gets called when you initialize your view.
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
        self.backgroundColor = Styleguide.colors.white
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
            guard let self = self else { return }
            self.button.title.text = ""
            self.button.onRelease = nil
            self.onRelease = nil
        }
    }
}
