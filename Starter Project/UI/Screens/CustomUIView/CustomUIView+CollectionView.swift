//
//  CustomUIView+CollectionView.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 3/12/23.
//

import Foundation
import UIKit

extension CustomUIView {

    func createLayout() -> UICollectionViewLayout {
        let estimatedHeight = CGFloat(100)
        let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .estimated(estimatedHeight))
        let item = NSCollectionLayoutItem(layoutSize: layoutSize)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: layoutSize,
                                                       subitem: item,
                                                       count: 1)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        section.interGroupSpacing = 10
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }

    func configureDataSource() {

        // Register the cells = please note that this is the equivalent of "cellForItemAt"
        // Except the cells do not need to be deQueued.
        let cellRegistration = UICollectionView.CellRegistration
        <DynamicLabelCell﻿, Int> { (cell, indexPath, _) in
            // Populate the cell with our item description.
            // Get the Cell
            guard let currentContent = LanguageCoordinator.shared.currentContent else {
                return
            }
            // Set the initial variables
            let labelI: String = currentContent.sample.sampleString
            var labelII: String = ""
            var labelIII: String = ""
            // Update the cell so that if the cell in a sequence, its 1 label, 2 labels and 3 labels.
            // i.e. index 1: only 1 label. index 2: first and second label; and index 3: all three labels.
            if indexPath.row % 3 == 0 {
                labelII = currentContent.sample.sampleStringII
                labelIII = currentContent.sample.sampleStringIII
            } else if indexPath.row % 2 == 0 {
                labelII = currentContent.sample.sampleStringII
            }
            // Update the cell
            cell.update(labelI: labelI, labelII: labelII, labelIII: labelIII)
        }

        // Create the datasource and tie it to the collectionView.
        // This is the part that ties the function above to your collectionview
        dataSource = UICollectionViewDiffableDataSource
        <Sections, Int>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, item: Int) -> UICollectionViewCell? in
            // Return the cell.
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        }

        // Load the data
        var snapshot = NSDiffableDataSourceSnapshot<Sections, Int>()
        snapshot.appendSections([.main])
        snapshot.appendItems([Int](0...100))
        dataSource.apply(snapshot, animatingDifferences: false)
    }}
