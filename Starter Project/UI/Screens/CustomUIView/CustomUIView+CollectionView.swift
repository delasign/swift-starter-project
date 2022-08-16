//
//  CustomUIView+CollectionView.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 8/16/22.
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
        return 1
    }
    /*
        This function determines the number of items in your collectionview.
        It's required and there is no default.
     */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    // MARK: Cell
    /*
        This function gets called everytime a cell needs to be rendered.
        When the cell gets 'reused' it will first call 'prepareForReuse' - which is where you should clear your cell.
        Once it's reused, in this function, you can call functionality to tweak it to your desired visual.
     */
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouselCell.identifier, for: indexPath) as? CarouselCell else {
            return UICollectionViewCell()
        }
        // This is where you implement any additional functionality, such as calling functions to update or alter your cell.
        return cell
    }
    
}
