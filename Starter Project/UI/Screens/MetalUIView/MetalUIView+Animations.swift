//
//  MetalUIView+Animations.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 10/11/23.
//

import Foundation
import UIKit

extension MetalUIView {
    func setupCADisplayLink() {
        displayLink = CADisplayLink(target: self, selector: #selector(self.updateAnimationVariables))
        // Start the display link
        displayLink.add(to: .main, forMode: .default)
        // Determine the refresh rate
        // Determine if the frame rate exists and if it is not 0
        // When this value is 0, the preferred frame rate is equal to the maximum refresh rate of the display, as indicated by the maximumFramesPerSecond property.
        if let frameRate = displayLink.preferredFrameRateRange.preferred, frameRate != 0.0 {
            displayLinkRefreshRate = CGFloat(1 / frameRate)
            debugPrint("\(MetalUIView.identifier) setupCADisplayLink \(DebuggingIdentifiers.actionOrEventSucceded) Refresh rate is \(frameRate) frames per second. This is the displayLink preferred FPS.")
        } else {
            let frameRate = UIScreen.main.maximumFramesPerSecond
            displayLinkRefreshRate = CGFloat(1 / frameRate)
            debugPrint("\(MetalUIView.identifier) setupCADisplayLink \(DebuggingIdentifiers.actionOrEventSucceded) Refresh rate is \(frameRate) frames per second. This matches the screen")
        }
        debugPrint("\(MetalUIView.identifier) setupCADisplayLink \(DebuggingIdentifiers.actionOrEventSucceded) Setup Complete.")
    }

    @objc private func updateAnimationVariables() {
        // Update the magnitude and direction
        if magnitudeIsGrowing {
            magnitude += displayLinkRefreshRate
        } else {
            magnitude -= displayLinkRefreshRate
        }

        if magnitude >= 1 {
            magnitude = 1
            magnitudeIsGrowing = false
        } else if magnitude <= 0 {
            magnitude = 0
            magnitudeIsGrowing = true
        }

        // determine the new origin
        let screenBounds = getCurrentScreenBounds()
        let initialOrigin: CGPoint = CGPoint(x: screenBounds.midX, y: screenBounds.midY)
        // The origin should only ever move 100 pixels north of the initial origin
        let yOffsetMaximum: CGFloat = -100
        self.origin = CGPoint(
            x: initialOrigin.x,
            y: initialOrigin.y + yOffsetMaximum * magnitude
        )
    }
}
