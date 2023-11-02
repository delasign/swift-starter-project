//
//  CustomUIView+Update.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 7/18/22.
//

import Foundation
import UIKit

extension CustomUIView {
    // MARK: Sample Update Functionality
    // onStateUpdate should be called when changing a view based on its state.
    func onStateUpdate() {

    }

    // updateLayoutConstraints should be called when a view changes orientation or resizes. This function should hold the changes in constraints across breakpoints.
    func updateLayoutConstraints() {
        DispatchQueue.main.async { [weak self] in
            guard let _ = self else { return}
        }
    }

    // onContentUpdate should be called when the LanguageCoordinator updates content.
    func onContentUpdate() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self, let currentContent = LanguageCoordinator.shared.currentContent else {
                debugPrint("\(CustomUIView.identifier) onContentUpdate \(DebuggingIdentifiers.actionOrEventFailed) Failed to update content, either the custom view does not exist or the current content is not available.")
                return
            }
            
            debugPrint("\(CustomUIView.identifier) onContentUpdate \(DebuggingIdentifiers.actionOrEventSucceded) Updated Content!")
        }
    }
    
    // MARK: Add / Remove Cell
    func addCell() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            // Update Count by 1
            self.numberOfCells += 1
            // Add Cell at the last index
            self.collectionView.insertItems(at: [
                IndexPath(item: (self.numberOfCells - 1), section: 0)
            ])
        }
    }
    
    func addCell(indexPath: IndexPath) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            // Update Count by 1
            self.numberOfCells += 1
            // Add Cell at the last index
            self.collectionView.insertItems(at: [
                indexPath
            ])
        }
    }
    
    func removeCell(indexPath: IndexPath) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            // Update Count by -1
            self.numberOfCells -= 1
            // Add Cell at the last index
            self.collectionView.deleteItems(at: [
                indexPath
            ])
        }
    }

}
