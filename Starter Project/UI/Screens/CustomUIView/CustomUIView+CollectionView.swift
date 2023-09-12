//
//  CustomUIView+CollectionView.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 9/12/23.
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
        return DataCoordinator.shared.sampleSwiftDataModels.count
    }

    // MARK: Cell
    /*
     This function gets called everytime a cell needs to be rendered.
     When the cell gets 'reused' it will first call 'prepareForReuse' - which is where you should clear your cell.
     Once it's reused, in this function, you can call functionality to tweak it to your desired visual.
     */
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SampleSwiftDataCell.identifier, for: indexPath) as? SampleSwiftDataCell else {
            return UICollectionViewCell()
        }
        cell.update(data: DataCoordinator.shared.sampleSwiftDataModels[indexPath.row])
        return cell
    }

    // MARK: Visual Parameters
    /*
     This function determines the size of the cell for each given indexPath (i.e. section and row).
     */
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Determine the frame
        let collectionViewFrame: CGRect = collectionView.frame
        let measuredWidth = collectionViewFrame.width
        return CGSize(width: measuredWidth, height: kButtonDimension + kPadding * 2)
    }

    /*
     This function determines the insets (also known as padding) for the collectionview.
     */
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(
            top: kPadding,
            left: 0,
            bottom: 0,
            right: 0
        )
    }

    /*
     This function determines the spacing between items within a section.
     */

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return kPadding
    }

    /*
     This function determines the spacing between sections.
     */

    func collectionView(_ collectionView: UICollectionView, layout
                            collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {

        return kPadding
    }

}
