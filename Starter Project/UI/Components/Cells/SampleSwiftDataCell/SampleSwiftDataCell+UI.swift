//
//  SampleSwiftDataCell+UI.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 9/12/23.
//

import Foundation
import UIKit
import TinyConstraints

extension SampleSwiftDataCell {
    // The setupUI function should be the only publically available class in this extension.
    // This can be called refreshUI if your app removes and adds content periodically.
    func setupUI() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.setupNumber()
            self.setupId()
            self.setupButton()
            self.setupFlipSwitch()
        }
    }

    // MARK: UI Setup Functionality
    private func setupNumber() {
        addSubview(number)
        number.centerY(to: self)
        number.left(to: self, offset: kPadding)
    }
    
    private func setupId() {
        addSubview(id)
        id.centerY(to: self)
        id.leftToRight(of: number, offset: kPadding)
    }
    
    private func setupButton() {
        addSubview(button)
        button.centerY(to: self)
        button.right(to: self, offset: -kPadding)
    }
    
    private func setupFlipSwitch() {
        flipSwitch.translatesAutoresizingMaskIntoConstraints = false
        addSubview(flipSwitch)
        flipSwitch.centerY(to: self)
        flipSwitch.rightToLeft(of: button, offset: -kPadding)
        flipSwitch.tintColor = Styleguide.getPrimaryColor()
        flipSwitch.thumbTintColor = flipSwitch.isOn ? Styleguide.getBackgroundColor() : Styleguide.getPrimaryColor()
    }

}
