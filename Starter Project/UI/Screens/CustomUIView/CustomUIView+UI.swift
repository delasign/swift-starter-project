//
//  CustomUIView+UI.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 7/18/22.
//

import Foundation
import UIKit
import TinyConstraints

extension CustomUIView {
    // The setupUI function should be the only publically available class in this extension.
    // This can be called refreshUI if your app removes and adds content periodically.
    func setupUI() {
        self.setupLabel()
        self.setupVariablePositionLabel()
    }

    // MARK: UI Setup Functionality
    private func setupLabel() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.addSubview(self.label)
            self.label.centerInSuperview()
        }
    }

    private func setupVariablePositionLabel() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.addSubview(self.variablePositionLabel)
            self.variablePositionLabel.attributedText = Styleguide.attributedText(text: "* * *")
            self.variablePositionLabel.sizeToFit()
            self.variablePositionLabelCenterX = self.variablePositionLabel.centerX(to: self, isActive: false)
            self.variablePositionLabelCenterY = self.variablePositionLabel.centerY(to: self, isActive: false)
            self.variablePositionLabelLeftToRightOf = self.variablePositionLabel.leftToRight(of: self.label, offset: kPadding, isActive: false)
            self.variablePositionLabelRightToLeftOf = self.variablePositionLabel.rightToLeft(of: self.label, offset: -kPadding, isActive: false)
            self.variablePositionLabelTopToBottomOf = self.variablePositionLabel.topToBottom(of: self.label, offset: kPadding, isActive: false)
            self.variablePositionLabelBottomToTopOf = self.variablePositionLabel.bottomToTop(of: self.label, offset: -kPadding, isActive: false)
            self.updateLayoutConstraints()
        }
    }

}
