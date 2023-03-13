//
//  CustomUIView+CollectionView.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 3/13/23.
//

import Foundation
import UIKit

extension CustomUIView {

    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { (sectionIndex, _) -> NSCollectionLayoutSection? in

            let itemWidth: NSCollectionLayoutDimension
            let itemHeight: NSCollectionLayoutDimension

            switch CustomUIView.CollectionViewSections[sectionIndex] {
            case .TitleA, .TitleB:
                itemWidth = .fractionalWidth(1)
                itemHeight = .absolute(50)

            case .A:
                itemWidth = .fractionalWidth(1 / 3)
                itemHeight = .fractionalWidth(1 / 3)
            case .B:
                itemWidth = .fractionalWidth(1)
                itemHeight = .absolute(100)
            }

            let inset: CGFloat = kPadding / 2

            // Item
            let itemSize = NSCollectionLayoutSize(widthDimension: itemWidth, heightDimension: itemHeight)
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)

            // Group
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(100))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

            // Section
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)

            return section
        })
        return layout
    }

    func configureDataSource() {

        // MARK: Register the cells
        // please note that this is the equivalent of "cellForItemAt"
        // Except the cells do not need to be deQueued.
        /// Title Cell
        let TitleCellRegistration = UICollectionView.CellRegistration
        <TitleCell, Int> { (cell, indexPath, _) in
            // Populate the cell with our item description.
            // Get the Cell
            guard let currentContent = LanguageCoordinator.shared.currentContent else {
                return
            }
            // Update the cell
            cell.update(text: indexPath.section == 0 ? currentContent.sample.sectionATitle : currentContent.sample.sectionBTitle)
        }
        /// Section A Cell
        let SectionACellRegistration = UICollectionView.CellRegistration
        <SectionACell, Int> { (cell, _, _) in
            // Update the cell
            cell.update(image: SampleImages.placeholder)
        }

        /// Section B Cell
        let SectionBCellRegistration = UICollectionView.CellRegistration
        <SectionBCell, Int> { (cell, _, _) in
            // Populate the cell with our item description.
            // Get the Cell
            guard let currentContent = LanguageCoordinator.shared.currentContent else {
                return
            }
            // Update the cell
            cell.update(image: SampleImages.placeholder,
                        title: currentContent.sample.sampleCellTitle,
                        body: currentContent.sample.sampleCellBody
            )
        }

        // MARK: Create the datasource and tie it to the collectionView.
        // This is the part that ties the function above to your collectionview
        dataSource = UICollectionViewDiffableDataSource
        <Sections, Int>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, item: Int) -> UICollectionViewCell? in
            // Return the cell.
            switch CustomUIView.CollectionViewSections[indexPath.section] {
            case .TitleA, .TitleB:
                return collectionView.dequeueConfiguredReusableCell(using: TitleCellRegistration, for: indexPath, item: item)
            case .A:
                return collectionView.dequeueConfiguredReusableCell(using: SectionACellRegistration, for: indexPath, item: item)
            case .B:
                return collectionView.dequeueConfiguredReusableCell(using: SectionBCellRegistration, for: indexPath, item: item)
            }

        }

        // MARK: Load the data
        var snapshot = NSDiffableDataSourceSnapshot<Sections, Int>()
        snapshot.appendSections(CustomUIView.CollectionViewSections)
        
        // !!! Note that the Ints (or identifiers, if you use data models instead of Ints) must be unique for you to use multiple sections !!!
        // In the case of Title A = we have done 0
        snapshot.appendItems([0], toSection: .TitleA)
        // In the case of A = we have done 1 -> 4
        snapshot.appendItems([Int](1...4), toSection: .A)
        // In the case of Title B = we have done 5
        snapshot.appendItems([5], toSection: .TitleB)
        // In the case of B = we have done 6 -> 11
        snapshot.appendItems([Int](6...11), toSection: .B)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}
