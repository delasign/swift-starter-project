//
//  CustomUIView+ScrollView.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 8/19/22.
//

import Foundation
import UIKit

private let extensionIdentifier: String = "-- SCROLLVIEW --"

extension CustomUIView {

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        debugPrint("\(CustomUIView.identifier) \(extensionIdentifier) \(DebuggingIdentifiers.actionOrEventInProgress) scrollViewDidEndDragging \(DebuggingIdentifiers.actionOrEventInProgress) willDecelerate \(decelerate).")
        // Only calculate index, if the scrollview will not decelerate.
        if !decelerate {
            self.calculateIndex()
        }
    }

    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        debugPrint("\(CustomUIView.identifier) \(extensionIdentifier) \(DebuggingIdentifiers.actionOrEventInProgress) scrollViewWillBeginDecelerating \(DebuggingIdentifiers.actionOrEventInProgress).")
        self.calculateIndex()
    }

    private func calculateIndex() {
        // Determine the current position
        let position: CGFloat = self.carousel.contentOffset.x
        /*
         Determine the index
         Please note that 300 is the size of the carousel card.
         This is declared in the +CollectionView extension on line 48.
         */
        let index: CGFloat = position / 300
        debugPrint("\(CustomUIView.identifier) \(extensionIdentifier) scrollViewDidEndDragging | measured index : \(index).")
        // Determine the delta (change) from current index
        let delta: CGFloat = index - CGFloat(self.currentIndex)
        debugPrint("\(CustomUIView.identifier) \(extensionIdentifier) scrollViewDidEndDragging | delta : \(delta).")
        /*
         Determine where to snap to
         If the absolute value of the delta is larger than 0.25 consider a movement valid.
         */
        if abs(delta) > 0.25 && delta > 0 {
            if delta > 0 {
                /*
                 Snap to index + 1 unless its larger than the number of cards available - 1 (4) - as 0 counts as a card.
                 Please note that the number of cards (5) is declared in the +CollectionView extension on line 26.
                 */
                let scrollToIndex = Int(ceil(index))
                if scrollToIndex > 4 {
                    self.snapToPositon(index: 4)
                } else {
                    self.snapToPositon(index: scrollToIndex)
                }
            } else {
                /*
                 Snap to index - 1 unless it's smaller than 0
                 */
                let scrollToIndex = Int(floor(index))
                if scrollToIndex < 0 {

                } else {
                    self.snapToPositon(index: scrollToIndex)
                }
            }

        } else {
            // Return to current index
            self.snapToPositon(index: self.currentIndex)
        }
    }

    private func snapToPositon(index: Int) {
        // Set the current index to the new index
        self.currentIndex = index
        // Scroll to the new index
        // Please note that this only works for a carousel with 1 section.
        self.carousel.scrollToItem(at: IndexPath(row: index, section: 0), at: .centeredHorizontally, animated: true)
        debugPrint("\(CustomUIView.identifier) \(extensionIdentifier) snapToPositon \(DebuggingIdentifiers.actionOrEventSucceded) Index : \(index).")
    }
}
