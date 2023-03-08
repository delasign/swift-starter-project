//
//  Offering+UI.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 3/8/23.
//

import Foundation
import UIKit

extension Offering {
    func setupUI() {
        setupCollectionView()
    }

    // MARK: UI Setup Functionality
    private func setupCollectionView() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.addSubview(self.collectionView)
            self.collectionView.edgesToSuperview()
            // Register the cells
            self.collectionView.register(ProductTile.self, forCellWithReuseIdentifier: ProductTile.identifier)
            // Set the delegate & datasource
            self.collectionView.delegate = self
            self.collectionView.dataSource = self
        }
    }
}
