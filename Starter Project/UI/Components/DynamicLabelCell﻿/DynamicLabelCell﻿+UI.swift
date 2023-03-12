//
//  DynamicLabelCell﻿+UI.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 3/12/23.
//

import Foundation
import UIKit
import TinyConstraints

extension DynamicLabelCell﻿ {
    // The setupUI function should be the only publically available class in this extension.

    /*
     It is important to note that for this process to work, the labels or layout must only be setup once and be cleared on prepareForReuse. If you setup the label or layout every time a UICollectionViewCell is reused or reloaded, it will not work.

     This implies that if you use a UICollectionViewCell that adapts its layout based on content (i.e. sometimes uses an image or a button, sometimes both and sometimes neither) a custom algorithm in step # must be applied to make sure that only the necessary views are considered.
     */
    func setupUI() {
        self.setupLabelI()
        self.setupLabelII()
        self.setupLabelIII()
    }

    // MARK: UI Setup Functionality
    private func setupLabelI() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.contentView.addSubview(self.labelI)
            self.labelI.top(to: self.contentView, offset: kPadding)
            self.labelI.left(to: self.contentView, offset: kPadding)
            self.labelI.right(to: self.contentView, offset: -kPadding)
        }
    }

    private func setupLabelII() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.contentView.addSubview(self.labelII)
            self.labelIITopConstraint = self.labelII.topToBottom(of: self.labelI, offset: kPadding)
            self.labelII.left(to: self.contentView, offset: kPadding)
            self.labelII.right(to: self.contentView, offset: -kPadding)
        }
    }

    private func setupLabelIII() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.contentView.addSubview(self.labelIII)
            self.labelIIITopConstraint = self.labelIII.topToBottom(of: self.labelII, offset: kPadding)
            self.labelIII.left(to: self.contentView, offset: kPadding)
            self.labelIII.right(to: self.contentView, offset: -kPadding)
            self.labelIII.bottom(to: self.contentView, offset: -kPadding)
        }
    }
}
