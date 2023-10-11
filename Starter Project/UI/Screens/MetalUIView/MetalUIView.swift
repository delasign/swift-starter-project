//
//  MetalUIView.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 10/1/23.
//

import Foundation
import UIKit
import Metal
import MetalKit

class MetalUIView: UIView {
    // MARK: Variables
    static let identifier: String = "[MetalUIView]"
    // MARK: UI
    var metalView: MTKView!
    var device: MTLDevice!
    var commandQueue: MTLCommandQueue!
    var pipelineState: MTLRenderPipelineState!
    // Animation Variables
    /// Declare the Display Link
    var displayLink: CADisplayLink = CADisplayLink()
    /// Declare a variable to track the refresh rate and set it to 60Hz to begin with.
    var displayLinkRefreshRate: CGFloat = 1 / 60
    /// Declare a magnitude variable that scales between 0 and 1
    var magnitude: CGFloat = 0
    /// Declare a variable that tracks the direction of motion. In this case, if its going (0 -> 1) is true and (1 -> 0) is false;
    var magnitudeIsGrowing: Bool = true
    /// Declare the origin that will be adapted as the magnitude changes. It is initially set to the center of the screen
    var origin: CGPoint = CGPoint(x: getCurrentScreenBounds().width / 2, y: getCurrentScreenBounds().height / 2)
    // MARK: Callbacks
    // MARK: Lifecycle
    // This is the function that gets called when you initialize your view.
    override init(frame: CGRect) {
        super.init(frame: frame)
        // MARK: UI Specific Setup
        // Before calling your setup functions, call any visual functionality that may be required:
        // i.e. background color, isHidden, isUserInteractionEnabled or translatesAutoresizingMaskIntoConstraints.
        self.translatesAutoresizingMaskIntoConstraints = false
//        self.backgroundColor = Styleguide.getBackgroundColor()
        // MARK: Functionality Setup
        self.setupUI()
        self.setupCADisplayLink()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.metalView.frame = self.bounds
        }
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
