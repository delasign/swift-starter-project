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
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.setupLabel()
        }
    }

    // MARK: UI Setup Functionality
    private func setupLabel() {
        guard let content = LanguageCoordinator.shared.currentContent else { return }
        label.attributedText = Styleguide.attributedText(text: content.sample.sampleString)
        addSubview(label)
        label.centerInSuperview()
    }
}
