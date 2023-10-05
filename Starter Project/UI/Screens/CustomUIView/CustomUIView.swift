//
//  CustomUIView.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 7/18/22.
//

import Foundation
import UIKit

class CustomUIView: UIView {
    // MARK: Variables
    static let identifier: String = "[CustomUIView]"
    // MARK: UI
    // Declare your CollectionView
    let collectionView: UICollectionView = {
          let layout = UICollectionViewFlowLayout()
          layout.scrollDirection = .vertical
          layout.minimumLineSpacing = kPadding
          layout.minimumInteritemSpacing = kPadding
          let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
          collectionView.translatesAutoresizingMaskIntoConstraints = false
          collectionView.backgroundColor = Styleguide.getBackgroundColor()

          return collectionView
      }()
      let collectionViewCellHeight: CGFloat = 80
    // MARK: Callbacks
    // MARK: Lifecycle
    // This is the function that gets called when you initialize your view.
    override init(frame: CGRect) {
        super.init(frame: frame)
        // MARK: UI Specific Setup
        // Before calling your setup functions, call any visual functionality that may be required:
        // i.e. background color, isHidden, isUserInteractionEnabled or translatesAutoresizingMaskIntoConstraints.
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = Styleguide.getBackgroundColor()
        // MARK: Functionality Setup
        self.setupUI()
        self.setupNotifications()
        self.setupGestures()
    }

    // This is the function that gets called when you remove your view from its superview.
    override func removeFromSuperview() {
        super.removeFromSuperview()
    }
    
    // This function gets called everytime a layout occurs either to this view or a subview of this view.
        override func layoutSubviews() {
            super.layoutSubviews()
            DispatchQueue.main.async {
                // Invalidate the carousel to make it lay itself out again.
                self.collectionView.collectionViewLayout.invalidateLayout()
            }
        }

    // viewWillTransition should be called when the view resizes or changes orientation.
    func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {

    }

    // This function is required for youa custom UIView.
    required init?(coder: NSCoder) {
        fatalError("did not instanstiate coder")
    }
}
