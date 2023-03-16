//
//  SectionTitleCell+UI.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 3/14/23.
//

import Foundation
import UIKit

extension SectionTitleCell {
    func setupUI() {
        self.setupTitle()
    }

    // MARK: UI Setup Functionality
    private func setupTitle() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.contentView.addSubview(self.title)
            self.title.top(to: self.contentView, offset: kPadding)
            self.title.left(to: self.contentView, offset: kPadding)
            self.title.right(to: self.contentView, offset: -kPadding)
            self.title.bottom(to: self.contentView, offset: -kPadding)
        }
    }
}
