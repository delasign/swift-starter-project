//
//  StoreKitProductNotification+UI.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 3/21/23.
//

import Foundation
import UIKit

extension StoreKitProductNotification {
    // The setupUI function should be the only publically available class in this extension.
    // This can be called refreshUI if your app removes and adds content periodically.
    func setupUI() {
        self.setupImageView()
        self.setupLabel()
    }

    // MARK: UI Setup Functionality
    private func setupImageView() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.addSubview(self.imageView)
            self.imageView.centerY(to: self)
            self.imageView.left(to: self, offset: kPadding)
            self.imageViewWidth = self.imageView.width(30)
            self.imageViewHeight = self.imageView.height(30)
        }
    }

    private func setupLabel() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.addSubview(self.label)
            self.label.centerY(to: self)
            self.label.leftToRight(of: self.imageView, offset: kPadding)
            self.label.right(to: self, offset: -kPadding)
        }
    }
}
