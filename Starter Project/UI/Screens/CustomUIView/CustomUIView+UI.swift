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
        self.setupCollectionView()
    }

    // MARK: UI Setup Functionality
    private func setupCollectionView() {
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.createLayout())
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView.backgroundColor = Styleguide.colors.white
        // Add the UICollectionView to the View
        self.addSubview(self.collectionView)
        // Setup the constraints
        self.collectionView.top(to: self)
        self.collectionView.left(to: self, offset: kPadding)
        self.collectionView.right(to: self, offset: -kPadding)
        self.collectionView.bottom(to: self)
        // Register the cells
        self.collectionView?.register(DynamicLabelCell﻿.self, forCellWithReuseIdentifier: DynamicLabelCell﻿.identifier)
    }
}
