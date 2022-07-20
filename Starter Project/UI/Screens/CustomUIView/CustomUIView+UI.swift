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
        self.setupImageView()
    }

    // MARK: UI Setup Functionality
    private func setupLabel() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.addSubview(self.label)
            self.label.centerInSuperview()
        }
    }

    private func setupImageView() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.addSubview(self.imageView)
            self.imageView.topToBottom(of: self.label, offset: 20)
            self.imageView.centerX(to: self)
            self.imageView.width(250)
            self.imageView.height(250)
            self.imageView.contentMode = .right
            self.imageView.layer.borderColor = UIColor.red.cgColor
            self.imageView.layer.borderWidth = 1
            self.imageView.layer.masksToBounds = true
            self.imageView.layer.backgroundColor = .white
        }
    }

}
