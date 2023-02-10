//
//  CustomUIView+Update.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 7/18/22.
//

import Foundation
import UIKit

extension CustomUIView {
    // MARK: Sample Update Functionality
    // onStateUpdate should be called when changing a view based on its state.
    func onStateUpdate() {

    }

    // updateLayoutConstraints should be called when a view changes orientation or resizes. This function should hold the changes in constraints across breakpoints.
    func updateLayoutConstraints() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return}
            
            debugPrint("\(CustomUIView.identifier) updateLayoutConstraints  \(DebuggingIdentifiers.actionOrEventInProgress) updateLayoutConstraints \(DebuggingIdentifiers.actionOrEventInProgress)")
            
            // Disable all constraints
            deactivateConstraints(constraints: [self.variablePositionLabelCenterX, self.variablePositionLabelCenterY, self.variablePositionLabelRightToLeftOf, self.variablePositionLabelLeftToRightOf, self.variablePositionLabelTopToBottomOf, self.variablePositionLabelBottomToTopOf])

            // Enable the right constraints
            switch getDeviceOrientation() {
            case .portrait, .faceUp, .faceDown:
                debugPrint("\(CustomUIView.identifier) \(DebuggingIdentifiers.actionOrEventSucceded) Applied Portrait Constraints.")
                activateConstraints(constraints: [self.variablePositionLabelCenterX, self.variablePositionLabelTopToBottomOf])
            case .landscapeRight:
                debugPrint("\(CustomUIView.identifier) \(DebuggingIdentifiers.actionOrEventSucceded) Applied Landscape Right Constraints.")
                activateConstraints(constraints: [self.variablePositionLabelCenterY, self.variablePositionLabelRightToLeftOf])
                break
            case .landscapeLeft:
                debugPrint("\(CustomUIView.identifier) \(DebuggingIdentifiers.actionOrEventSucceded) Applied Landscape Left Constraints.")
                activateConstraints(constraints: [self.variablePositionLabelCenterY, self.variablePositionLabelLeftToRightOf])
                break
            case .portraitUpsideDown:
                debugPrint("\(CustomUIView.identifier) \(DebuggingIdentifiers.actionOrEventSucceded) Applied Portrait Up Side Down Constraints.")
                activateConstraints(constraints: [self.variablePositionLabelCenterX, self.variablePositionLabelBottomToTopOf])
                break
            default:
                debugPrint("\(CustomUIView.identifier) \(DebuggingIdentifiers.actionOrEventFailed) Failed to apply constraints.")
                break
            }
            // set needs layout and layout if needed
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
    }

    // onContentUpdate should be called when the LanguageCoordinator updates content.
    func onContentUpdate() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self, let currentContent = LanguageCoordinator.shared.currentContent else {
                debugPrint("\(CustomUIView.identifier) onContentUpdate \(DebuggingIdentifiers.actionOrEventFailed) Failed to update content, either the custom view does not exist or the current content is not available.")
                return
            }
            self.label.attributedText = Styleguide.attributedText(text: currentContent.sample.sampleString)
            self.label.sizeToFit()
            debugPrint("\(CustomUIView.identifier) onContentUpdate \(DebuggingIdentifiers.actionOrEventSucceded) Updated Content!")
        }
    }
}
