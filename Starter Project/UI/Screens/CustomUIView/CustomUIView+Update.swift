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
            guard let self = self,
                  let variablePositionLabelCenterX = self.variablePositionLabelCenterX,
                  let variablePositionLabelCenterY = self.variablePositionLabelCenterY,
                  let variablePositionLabelRightToLeftOf = self.variablePositionLabelRightToLeftOf,
                  let variablePositionLabelLeftToRightOf = self.variablePositionLabelLeftToRightOf,
                  let variablePositionLabelTopToBottomOf = self.variablePositionLabelTopToBottomOf,
                  let variablePositionLabelBottomToTopOf = self.variablePositionLabelBottomToTopOf,
                  let interfaceOrientation = UIApplication.shared.windows.first?.windowScene?.interfaceOrientation
            else { return}

            // Disable all constraints
            [variablePositionLabelCenterX, variablePositionLabelCenterY, variablePositionLabelRightToLeftOf, variablePositionLabelLeftToRightOf, variablePositionLabelTopToBottomOf, variablePositionLabelBottomToTopOf].deActivate()
            debugPrint("\(CustomUIView.identifier)  \(DebuggingIdentifiers.actionOrEventInProgress) updateLayoutConstraints \(DebuggingIdentifiers.actionOrEventInProgress)")

            var orientation = UIDevice.current.orientation
            // Initially the orientation is unknown so we need to check based on the application window orientation.
            if !orientation.isValidInterfaceOrientation {
                debugPrint("\(CustomUIView.identifier)  \(DebuggingIdentifiers.actionOrEventFailed) Orientation is unknown.")
                debugPrint("\(CustomUIView.identifier)  \(DebuggingIdentifiers.actionOrEventInProgress) Trying through the window orientation \(interfaceOrientation) \(DebuggingIdentifiers.actionOrEventInProgress)")
                // Notice that UIDeviceOrientation.landscapeRight is assigned to UIInterfaceOrientation.landscapeLeft and UIDeviceOrientation.landscapeLeft is assigned to UIInterfaceOrientation.landscapeRight. The reason for this is that rotating the device requires rotating the content in the opposite direction.
                // Reference : https://developer.apple.com/documentation/uikit/uiinterfaceorientation
                switch interfaceOrientation {
                case .portrait:
                    debugPrint("\(CustomUIView.identifier) \(DebuggingIdentifiers.actionOrEventSucceded) Setting orientation to portrait.")
                    orientation = .portrait
                    break
                case .landscapeRight:
                    debugPrint("\(CustomUIView.identifier) \(DebuggingIdentifiers.actionOrEventSucceded) Setting orientation to landscape left, as UIDeviceOrientation.landscapeRight is assigned to UIInterfaceOrientation.landscapeLeft.")
                    orientation = .landscapeLeft
                    break
                case .landscapeLeft:
                    debugPrint("\(CustomUIView.identifier) \(DebuggingIdentifiers.actionOrEventSucceded) Setting orientation to landscape right, as UIDeviceOrientation.landscapeLeft is assigned to UIInterfaceOrientation.landscapeRight.")
                    orientation = .landscapeRight
                    break
                case .portraitUpsideDown:
                    debugPrint("\(CustomUIView.identifier) \(DebuggingIdentifiers.actionOrEventSucceded) Setting orientation to portrait upside down.")
                    orientation = .portraitUpsideDown
                    break
                default:
                    debugPrint("\(CustomUIView.identifier)  \(DebuggingIdentifiers.actionOrEventFailed) Status Bar Orientation is unknown.")
                    break
                }
            }

            // Enable the right constraints
            switch orientation {
            case .portrait, .faceUp, .faceDown:
                debugPrint("\(CustomUIView.identifier) \(DebuggingIdentifiers.actionOrEventSucceded) Applied Portrait Constraints.")
                [variablePositionLabelCenterX, variablePositionLabelTopToBottomOf].activate()
            case .landscapeRight:
                debugPrint("\(CustomUIView.identifier) \(DebuggingIdentifiers.actionOrEventSucceded) Applied Landscape Right Constraints.")
                [variablePositionLabelCenterY, variablePositionLabelRightToLeftOf].activate()
                break
            case .landscapeLeft:
                debugPrint("\(CustomUIView.identifier) \(DebuggingIdentifiers.actionOrEventSucceded) Applied Landscape Left Constraints.")
                [variablePositionLabelCenterY, variablePositionLabelLeftToRightOf].activate()
                break
            case .portraitUpsideDown:
                debugPrint("\(CustomUIView.identifier) \(DebuggingIdentifiers.actionOrEventSucceded) Applied Portrait Up Side Down Constraints.")
                [variablePositionLabelCenterX, variablePositionLabelBottomToTopOf].activate()
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
