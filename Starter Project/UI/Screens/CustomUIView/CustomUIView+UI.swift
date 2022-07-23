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
        self.setupScrollView()
        self.setupImageView()
        self.setupTitleLabel()
        self.setupDateLabel()
        self.setupPriceLabel()
        self.setupDescriptionLabel()
    }

    // MARK: UI Setup Functionality
    private func setupScrollView() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.addSubview(self.scrollView)
            self.scrollView.edgesToSuperview()
        }
    }

    private func setupImageView() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.scrollView.addSubview(self.imageView)
            self.imageView.top(to: self.scrollView, offset: 100)
            self.imageView.centerX(to: self.scrollView)
            self.imageView.height(UIScreen.main.bounds.width - 2 * kPadding)
            self.imageView.width(UIScreen.main.bounds.width - 2 * kPadding)
        }
    }

    private func setupTitleLabel() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.scrollView.addSubview(self.titleLabel)
            self.titleLabel.topToBottom(of: self.imageView, offset: kPadding)
            self.titleLabel.left(to: self.scrollView, offset: kPadding)
            self.titleLabel.right(to: self.scrollView.frameLayoutGuide)
        }
    }

    private func setupDateLabel() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.scrollView.addSubview(self.dateLabel)
            self.dateLabel.topToBottom(of: self.titleLabel, offset: kPadding)
            self.dateLabel.left(to: self.scrollView, offset: kPadding)
        }
    }

    private func setupPriceLabel() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.scrollView.addSubview(self.priceLabel)
            self.priceLabel.topToBottom(of: self.titleLabel, offset: kPadding)
            self.priceLabel.right(to: self.scrollView.frameLayoutGuide, offset: -kPadding)
        }
    }

    private func setupDescriptionLabel() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.scrollView.addSubview(self.descriptionLabel)
            self.descriptionLabel.topToBottom(of: self.dateLabel, offset: kPadding)
            self.descriptionLabel.left(to: self.scrollView, offset: kPadding)
            self.descriptionLabel.right(to: self.scrollView.frameLayoutGuide, offset: -kPadding)
        }
    }
}
