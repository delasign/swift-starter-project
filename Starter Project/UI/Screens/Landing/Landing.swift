//
//  CustomUIView.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 7/18/22.
//

import Foundation
import UIKit

class Landing: UIView {
    // MARK: Variables
    static let identifier: String = "[Landing]"
    // MARK: UI
    let tutorialLabel: UILabel = Styleguide.createAttributedHeader()
    let logo: UIImageView = UIImageView(image: UIImage(named: Images.logo))
    let visitOurBlogButton: Button = Button(type: .primary)
    let startButton: Button = Button(type: .secondary)
    // MARK: Lifecycle
    // This is the function that gets called when you initialize your view.
    override init(frame: CGRect) {
        super.init(frame: frame)
        // MARK: UI Specific Setup
        // Before calling your setup functions, call any visual functionality that may be required:
        // i.e. background color, isHidden, isUserInteractionEnabled or translatesAutoresizingMaskIntoConstraints.
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = Styleguide.colors.white
        // MARK: Functionality Setup
        self.setupUI()
        self.setupNotifications()
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