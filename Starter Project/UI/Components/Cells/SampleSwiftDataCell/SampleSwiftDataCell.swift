//
//  SampleSwiftDataCell.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 9/12/23.
//

import Foundation
import UIKit
import StoreKit

class SampleSwiftDataCell: UICollectionViewCell {
    // MARK: Variables
    static var identifier: String = "SampleSwiftDataCell"
    var data: SampleSwiftDataModel?
    // MARK: UI
    let id: UILabel = Styleguide.createAttributedStyle()
    let number: UILabel = Styleguide.createAttributedStyle()
    let flipSwitch: UISwitch = UISwitch()
    let button: ActionButton = ActionButton(type: .delete)
    // MARK: Lifecycle
    // This is the function that gets called when you initialize your view.
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Styleguide.getBackgroundColor()
        self.setupUI()
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
            self.data = nil
            self.id.text = ""
            self.number.text = ""
            self.flipSwitch.isOn = false
            flipSwitch.removeTarget(self, action: #selector(self.onFlipSwitchToggle), for: .touchUpInside)
            self.button.onRelease = nil
        }
    }
}
