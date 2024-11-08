//
//  NavigationButton.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 9/13/23.
//

import Foundation
import UIKit

class NavigationButton: UIView {
    // MARK: Variables
    static let identifier: String = "[NavigationButton]"
    // MARK: UI
    let imageView: UIImageView = UIImageView(image: UIImage(systemName: SFSymbols.menu)?.withRenderingMode(.alwaysTemplate))
    // MARK: Callbacks
    var onRelease: (() -> Void)?
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
        self.setupNotifications()
        self.setupUI()
        self.width(kButtonDimension)
        self.height(kButtonDimension)
        self.layer.cornerRadius = kButtonDimension / 2
        // MARK: Shadow
        self.layer.shadowOpacity = 1
        self.layer.shadowColor = Styleguide.getPrimaryColor().cgColor
        self.layer.shadowPath = UIBezierPath(
            roundedRect: CGRect(x: 0, y: 0, width: kButtonDimension, height: kButtonDimension),
            cornerRadius: kButtonDimension / 2).cgPath
        self.layer.shadowOffset = CGSize(width: 0, height: kShadowSize)
        self.layer.shadowOpacity = 0.5
    }

    // viewWillTransition should be called when the view resizes or changes orientation.
    func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {

    }

    // This function is required for youa custom UIView.
    required init?(coder: NSCoder) {
        fatalError("did not instanstiate coder")
    }
}
