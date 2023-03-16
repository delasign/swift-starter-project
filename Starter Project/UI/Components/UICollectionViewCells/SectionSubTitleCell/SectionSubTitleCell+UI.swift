//
//  SectionTitleCell+UI.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 3/15/23.
//

import Foundation
import UIKit

extension SectionSubTitleCell {
    func setupUI() {
        self.setupTitle()
    }

    // MARK: UI Setup Functionality
    private func setupTitle() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.contentView.addSubview(self.title)
            self.title.edges(to: self.contentView, insets: UIEdgeInsets(top: kPadding, left: kPadding, bottom: kPadding, right: kPadding))
        }
    }
}
