//
//  SectionBCell+UI.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 3/13/23.
//

import Foundation
import UIKit

extension SectionBCell {
    func setupUI() {
        setupImageView()
        setupTitleLabel()
        setupBodyLabel()
    }

    private func setupImageView() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.imageView.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(self.imageView)
            self.imageView.left(to: self)
            self.imageView.top(to: self)
            self.imageView.bottom(to: self)
            self.imageView.widthToHeight(of: self)
        }
    }

    private func setupTitleLabel() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.addSubview(self.titleLabel)
            self.titleLabel.leftToRight(of: self.imageView, offset: kPadding)
            self.titleLabel.top(to: self)
        }
    }

    private func setupBodyLabel() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.addSubview(self.bodyLabel)
            self.bodyLabel.topToBottom(of: self.titleLabel, offset: kPadding / 2)
            self.bodyLabel.left(to: self.titleLabel)
            self.bodyLabel.right(to: self, offset: -kPadding)
        }
    }
}
