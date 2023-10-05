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
            self.setupSearchBar()
            self.setupCollectionView()
        }
    }

    // MARK: UI Setup Functionality
    private func setupSearchBar() {
        addSubview(searchBar)
        searchBar.left(to: self)
        searchBar.top(to: self)
        searchBar.right(to: self)
        searchBar.height(100)
    }
    
    private func setupCollectionView() {
        // Add the UICollectionView to the View
        addSubview(collectionView)
        // Setup the constraints
        collectionView.topToBottom(of: self.searchBar)
        collectionView.left(to: self, offset: kPadding)
        collectionView.right(to: self, offset: -kPadding)
        collectionView.bottom(to: self)
        // Register the cells
        collectionView.register(PokemonV2Cell.self, forCellWithReuseIdentifier: PokemonV2Cell.identifier)
        // Set the delegate & datasource
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    
}
