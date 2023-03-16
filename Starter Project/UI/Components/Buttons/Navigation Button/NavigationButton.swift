//
//  NavigationButton.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 3/8/23.
//

import Foundation
import UIKit

class NavigationButton: UIView {
    // MARK: Variables
    static let identifier: String = "[NavigationButton]"
    // MARK: UI
    let symbol: UIImageView = UIImageView(image: UIImage(named: Images.back)?.withRenderingMode(.alwaysTemplate))
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
        self.height(kButtonDimension)
        self.width(kButtonDimension)
        self.layer.cornerRadius = kButtonDimension / 2
        self.backgroundColor = Styleguide.colors.white
        // MARK: Functionality Setup
        self.setupUI()
        self.setupNotifications()
    }

    override func layoutSubviews() {
        // Shadow
        self.layer.cornerRadius = kButtonDimension / 2
        self.layer.shadowOpacity = 1
        self.layer.shadowColor = Styleguide.colors.black.cgColor
        self.layer.shadowPath = UIBezierPath(
            roundedRect: CGRect(x: 0, y: 0, width: self.frame.width, height: kButtonDimension),
            cornerRadius: kButtonDimension / 2).cgPath
        self.layer.shadowOffset = CGSize(width: 0, height: 5)
        self.layer.shadowOpacity = 0.5
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
