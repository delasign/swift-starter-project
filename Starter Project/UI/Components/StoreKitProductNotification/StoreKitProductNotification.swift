//
//  StoreKitProductNotification.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 3/21/23.
//

import Foundation
import UIKit
import StoreKit

class StoreKitProductNotification: UIView {
    // MARK: Variables
    static let identifier: String = "[StoreKitNotification]"
    var type: StoreKitNotificationType = .purchased
    var product: Product?
    // MARK: UI
    let label: UILabel = Styleguide.createAttributedProductDetail()
    let imageView: UIImageView = UIImageView()
    var imageViewWidth: NSLayoutConstraint?
    var imageViewHeight: NSLayoutConstraint?
    var heightConstraint: NSLayoutConstraint?
    // MARK: Lifecycle
    // This is the function that gets called when you initialize your view.
    override init(frame: CGRect) {
        super.init(frame: frame)
        // MARK: UI Specific Setup
        // Before calling your setup functions, call any visual functionality that may be required:
        // i.e. background color, isHidden, isUserInteractionEnabled or translatesAutoresizingMaskIntoConstraints.
        self.translatesAutoresizingMaskIntoConstraints = false
        // Set the width to be maximum the width of the screen minus 2 * padding
        self.width(UIScreen.main.bounds.width - 2 * kPadding)
        // Height constraint initially set to 100 - with the purpose of being able to change it
        self.heightConstraint = self.height(100)
        // The view is initially hidden with an alpha of 0
        self.isHidden = true
        self.alpha = 0
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

    // MARK: Utilities

    func getBackgroundColor() -> UIColor {
        switch type {
        case .purchased, .refundSucceeded:
            return Styleguide.colors.green
        case .pending, .refundPending:
            return Styleguide.colors.purple
        case .failed, .refundFailed:
            return Styleguide.colors.red
        case .refundCancelled:
            return Styleguide.colors.black
        }
    }
}
