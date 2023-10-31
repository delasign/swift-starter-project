//
//  ProgressIndicator.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 10/31/23.
//

import Foundation
import UIKit

class ProgressIndicator: UIView {
    // MARK: Variables
    static let identifier: String = "[ProgressIndicator]"
    var dimension: CGFloat = 150
    var lineWidth: CGFloat = 10
    var color: UIColor = Styleguide.getPrimaryColor()

    // MARK: UI
    var background: UIView = UIView()
    var widthConstraint: NSLayoutConstraint?
    var heightConstraint: NSLayoutConstraint?
    var gradientMask = UIView()

    let backgroundCircle = CAShapeLayer()
    let circle = CAShapeLayer()
    var strokeStart: CGFloat = 0.0
    var strokeEnd: CGFloat = 0.0

    var animationTimer: Timer?
    var isCurrentlyDrawingItselfForTheFirstTime: Bool = false
    var animationIsActive: Bool = true
    var animateTillCompletion: Bool = false
    var animationInProgress: Bool = false

    // MARK: Callbacks
    var onProgressChangedAnimationComplete: (() -> Void)?
    // MARK: Lifecycle
    // This is the function that gets called when you initialize your view.
    override init(frame: CGRect) {
        super.init(frame: frame)
        // MARK: UI Specific Setup
        // Before calling your setup functions, call any visual functionality that may be required:
        // i.e. background color, isHidden, isUserInteractionEnabled or translatesAutoresizingMaskIntoConstraints.
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = true
        setupNotifications()
        setupUI()
        background.backgroundColor = Styleguide.getPrimaryColor()

        self.widthConstraint = self.width(dimension)
        self.heightConstraint = self.height(dimension)

    }

    convenience init(color: UIColor, dimension: CGFloat, lineWidth: CGFloat) {
        self.init(frame: .zero)
        self.dimension = dimension
        self.lineWidth = lineWidth
        self.color = color
        self.update(color: color,
                    circleFillColor: nil,
                    dimension: dimension,
                    lineWidth: lineWidth
        )
    }

    // This is the function that gets called when you remove your view from its superview.
    override func removeFromSuperview() {
        super.removeFromSuperview()
    }

    // viewWillTransition should be called when the view resizes or changes orientation.
    func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {

    }

    override func layoutSubviews() {
        let dimension = dimension - kPadding
        let cornerRadius = dimension / 2
        self.circle.path = UIBezierPath(
            roundedRect: CGRect(x: kPadding / 2, y: kPadding / 2, width: dimension, height: dimension),
            byRoundingCorners: .allCorners,
            cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)).cgPath
    }

    // This function is required for youa custom UIView.
    required init?(coder: NSCoder) {
        fatalError("did not instanstiate coder")
    }
}
