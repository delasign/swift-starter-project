//
//  NavigationButton+UI.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 3/8/23.
//

import Foundation
import UIKit
import TinyConstraints

extension NavigationButton {
    // The setupUI function should be the only publically available class in this extension.
    // This can be called refreshUI if your app removes and adds content periodically.
    func setupUI() {
        self.setupSymbol()
    }

    // MARK: UI Setup Functionality
    private func setupSymbol() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.addSubview(self.symbol)
            self.symbol.edgesToSuperview()
            self.symbol.tintColor = Styleguide.colors.black
        }
    }
}
