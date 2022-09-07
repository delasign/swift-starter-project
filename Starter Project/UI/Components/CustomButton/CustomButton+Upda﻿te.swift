//
//  CustomButton+Update.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 9/7/22.
//

import Foundation
import UIKit

extension CustomButton {
    // onContentUpdate should be called when the LanguageCoordinator updates content.
    func onContentUpdate() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self, let currentContent = LanguageCoordinator.shared.currentContent else {
                debugPrint("\(CustomButton.identifier) onContentUpdate \(DebuggingIdentifiers.actionOrEventFailed) Failed to update content, either the custom view does not exist or the current content is not available.")
                return
            }
            // Set the button label to the relevant content.
            self.label.attributedText = Styleguide.attributedCustomButtonText(text: currentContent.buttons.pressMe)

            debugPrint("\(CustomButton.identifier) onContentUpdate \(DebuggingIdentifiers.actionOrEventSucceded) Updated Content!")
        }
    }
}
