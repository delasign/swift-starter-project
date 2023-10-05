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
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            // Add the UICollectionView to the View
            self.addSubview(self.collectionView)
            // Setup the constraints
            self.collectionView.top(to: self, offset: 100)
            self.collectionView.left(to: self, offset: kPadding)
            self.collectionView.right(to: self, offset: -kPadding)
            self.collectionView.bottom(to: self)
            // Register the cells
            self.collectionView.register(PokemonV2Cell.self, forCellWithReuseIdentifier: PokemonV2Cell.identifier)
            // Set the delegate & datasource
            self.collectionView.delegate = self
            self.collectionView.dataSource = self
        }
    }
}
