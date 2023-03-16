//
//  RestorePurchasesCell+UI.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 3/16/23.
//

import Foundation
import UIKit

extension RestorePurchasesCell {
    func setupUI() {
        self.setupButton()
    }

    // MARK: UI Setup Functionality
    private func setupButton() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.contentView.addSubview(self.button)
            self.button.top(to: self.contentView)
            self.button.left(to: self.contentView, offset: kPadding)
            self.button.right(to: self.contentView, offset: -kPadding)
            self.button.bottom(to: self.contentView, priority: UILayoutPriority(999))
        }
    }
}
