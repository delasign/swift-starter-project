//
//  CarouselIndicator.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 8/19/22.
//

import Foundation
import UIKit

class CarouselIndicator: UIView {
    // MARK: Variables
    static let identifier: String = "[CarouselIndicator]"
    // Declare the callback for when the cell is touched.
    var onRelease: (()->())?
    // MARK: UI
    // MARK: Lifecycle
    
    // This is the function that gets called when you initialize your view.
    override init(frame: CGRect) {
        super.init(frame: frame)
        // MARK: UI Specific Setup
        // Before calling your setup functions, call any visual functionality that may be required:
        // i.e. background color, isHidden, isUserInteractionEnabled or translatesAutoresizingMaskIntoConstraints.
        self.backgroundColor = .black
        // MARK: Functionality Setup
        self.setupGestures()
    }
    
    // This is the function that gets called when you remove your view from its superview.
    override func removeFromSuperview() {
        super.removeFromSuperview()
    }
    
    // viewWillTransition should be called when the view resizes or changes orientation.
    func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {

    }

    // This function is required for youa custom UIView.
    required init?(coder: NSCoder) {
        fatalError("did not instanstiate coder")
    }
}