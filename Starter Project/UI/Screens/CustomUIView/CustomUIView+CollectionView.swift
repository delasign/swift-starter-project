//
//  CustomUIView+CollectionView.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 8/20/22.
//

import Foundation
import UIKit

extension CustomUIView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    // MARK: Number of Sections & Items
    /*
        This function determines the number of sections in your collectionview.
        It's not required & it defaults to 1.
     */
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.sections.count
    }
    /*
        This function determines the number of items in your collectionview.
        It's required and there is no default.
     */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch self.sections[section] {
        case .A:
            return self.numberOfCellsInSectionA
        case .B:
            return self.numberOfCellsInSectionB
        }
    }
    
    // MARK: Cell
    /*
        This function gets called everytime a cell needs to be rendered.
        When the cell gets 'reused' it will first call 'prepareForReuse' - which is where you should clear your cell.
        Once it's reused, in this function, you can call functionality to tweak it to your desired visual.
     */
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case 0:
            return titleCell(collectionView, cellForItemAt: indexPath)
        default:
            switch self.sections[indexPath.section] {
            case .A:
                return sectionACell(collectionView, cellForItemAt: indexPath)
            case .B:
                return sectionBCell(collectionView, cellForItemAt: indexPath)
            }
        }
    }
    
    func titleCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCell.identifier, for: indexPath) as? TitleCell else {
            return UICollectionViewCell()
        }
        // This is where you implement any additional functionality, such as calling functions to update or alter your cell.
        // In the case of the title cell for the title cell, we want to update the title, if the content is available.
        if let content = LanguageCoordinator.shared.currentContent {
            // Set the text
            let text: String
            switch self.sections[indexPath.section] {
            case .A:
                text = content.sample.sectionATitle
                break
            case .B:
                text = content.sample.sectionBTitle
                break
            }
            // Update the cell
            cell.update(text: text)
        }
        
        return cell
    }
    
    func sectionACell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SectionACell.identifier, for: indexPath) as? SectionACell else {
            return UICollectionViewCell()
        }
        // This is where you implement any additional functionality, such as calling functions to update or alter your cell.
        cell.update(image: SampleImages.placeholder)
        return cell
    }
    
    func sectionBCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SectionBCell.identifier, for: indexPath) as? SectionBCell else {
            return UICollectionViewCell()
        }
        // This is where you implement any additional functionality, such as calling functions to update or alter your cell.
        // In the case of the title cell for the title cell, we want to update the title and images, if the content is available.
        if let content = LanguageCoordinator.shared.currentContent {
            // Update the cell
            cell.update(image: SampleImages.placeholder,
                        title: content.sample.sampleCellTitle,
                        body: content.sample.sampleCellBody)
        }
        return cell
    }
}
