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
            setupCollectionView()
            setupAddCellButton()
        }
    }

    // MARK: UI Setup Functionality
    private func setupCollectionView() {
        // Add the UICollectionView to the View
        addSubview(collectionView)
        // Setup the constraints
        collectionView.top(to: self, offset: kPadding)
        collectionView.left(to: self, offset: kPadding)
        collectionView.right(to: self, offset: -kPadding)
        collectionView.bottom(to: self, offset: -kBottomMargin)
        // Register the cells
        collectionView.register(SampleCollectionViewCell.self, forCellWithReuseIdentifier: SampleCollectionViewCell.identifier)
        // Set the delegate & datasource
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setupAddCellButton() {
        guard let currentContent = LanguageCoordinator.shared.currentContent?.sample else { return }
        addCellButton.update(text: currentContent.addCell)
        addSubview(addCellButton)
        addCellButton.left(to: self, offset: kPadding)
        addCellButton.right(to: self, offset: -kPadding)
        addCellButton.bottom(to: self, offset: -kPadding)
        addCellButton.height(kButtonDimension)
        
        addCellButton.onRelease = { [weak self] in
            guard let self = self else { return }
            // Add Cell
            self.addCell()
        }
    }
}
