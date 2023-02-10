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
    let label: UILabel = Styleguide.createAttributedStyle()
    let variablePositionLabel: UILabel = Styleguide.createAttributedStyle()
    // Declare Constraints
    var variablePositionLabelCenterY: NSLayoutConstraint?
    var variablePositionLabelCenterX: NSLayoutConstraint?
    var variablePositionLabelLeftToRightOf: NSLayoutConstraint?
    var variablePositionLabelRightToLeftOf: NSLayoutConstraint?
    var variablePositionLabelTopToBottomOf: NSLayoutConstraint?
    var variablePositionLabelBottomToTopOf: NSLayoutConstraint?
    // MARK: Callbacks
    // MARK: Lifecycle
    // This is the function that gets called when you initialize your view.
    override init(frame: CGRect) {
        super.init(frame: frame)
        // MARK: UI Specific Setup
        // Before calling your setup functions, call any visual functionality that may be required:
        // i.e. background color, isHidden, isUserInteractionEnabled or translatesAutoresizingMaskIntoConstraints.
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .black
        // Begin listening for orientation changes
        UIDevice.current.beginGeneratingDeviceOrientationNotifications()
        // MARK: Functionality Setup
        self.setupUI()
        self.setupNotifications()
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
