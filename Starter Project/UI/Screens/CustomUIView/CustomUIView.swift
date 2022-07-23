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
    let scrollView: UIScrollView = UIScrollView()
    let imageView: UIImageView = UIImageView(image: UIImage(named: SampleImages.placeholder))
    let titleLabel: UILabel = Styleguide.createHeadlineStyle(text: "Event Title")
    let dateLabel: UILabel = Styleguide.createHeadlineStyle(text: "Date")
    let priceLabel: UILabel = Styleguide.createHeadlineStyle(text: "Price")
    let descriptionLabel: UILabel = Styleguide.createTextStyle(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut vitae augue vestibulum, pharetra arcu ac, mollis nibh. Vestibulum tristique neque eget urna venenatis, sed aliquet arcu consectetur. Integer lobortis lacus id purus placerat, nec sollicitudin quam pharetra. Sed placerat libero a lorem aliquam, at blandit elit volutpat. Nullam risus metus, porttitor at rhoncus vel, aliquet eget sem. Integer diam dolor, aliquam et purus in, pharetra maximus quam. Morbi auctor sed diam vel efficitur. Nulla sagittis ipsum orci, non euismod felis elementu")
    // MARK: Lifecycle
    // This is the function that gets called when you initialize your view.
    override init(frame: CGRect) {
        super.init(frame: frame)
        // MARK: UI Specific Setup
        // Before calling your setup functions, call any visual functionality that may be required:
        // i.e. background color, isHidden, isUserInteractionEnabled or translatesAutoresizingMaskIntoConstraints.
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .white
        // MARK: Functionality Setup
        self.setupUI()
        self.setupNotifications()
        self.setupGestures()
    }

    // This is the function that gets called when you remove your view from its superview.
    override func removeFromSuperview() {
        super.removeFromSuperview()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.scrollView.updateContentView(offset: 100)
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
