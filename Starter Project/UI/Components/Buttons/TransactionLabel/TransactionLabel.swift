//
//  TransactionLabel.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 3/8/23.
//

import Foundation
import UIKit
import StoreKit

class TransactionLabel: UIView {
    // MARK: Variables
    static let identifier: String = "[TransactionLabel]"
    var type: TransactionLabelType = .free
    var product: Product?
    // MARK: UI
    let label: UILabel = Styleguide.createAttributedLabel()
    let imageView: UIImageView = UIImageView()
    var imageViewWidth: NSLayoutConstraint?
    var imageViewHeight: NSLayoutConstraint?
    // MARK: Lifecycle
    // This is the function that gets called when you initialize your view.
    override init(frame: CGRect) {
        super.init(frame: frame)
        // MARK: UI Specific Setup
        // Before calling your setup functions, call any visual functionality that may be required:
        // i.e. background color, isHidden, isUserInteractionEnabled or translatesAutoresizingMaskIntoConstraints.
        self.translatesAutoresizingMaskIntoConstraints = false
        self.height(kButtonDimension)
        self.width(120)
        self.layer.cornerRadius = kButtonDimension / 2
        self.setupNotifications()
    }

    func configure(type: TransactionLabelType, product: Product? = nil) {
        // Reset
        self.removeAllViews()
        // Setup
        self.type = type
        if let product = product {
            self.product = product
        }
        self.backgroundColor = self.getBackgroundColor()
        // MARK: Functionality Setup
        self.setupUI()
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

    // MARK: Utilities

    func getBackgroundColor() -> UIColor {
        switch type {
        case .free, .price, .subscriptionPrice:
            return Styleguide.colors.white
        case .introductoryOffer:
            return Styleguide.colors.blue
        case .pending:
            return Styleguide.colors.purple
        case .purchased:
            return Styleguide.colors.green
        case .warning:
            return Styleguide.colors.red
        }
    }
}
