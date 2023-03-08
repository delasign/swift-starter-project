//
//  NavigationHeader+Update.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 3/8/23.
//

import Foundation
import UIKit

extension NavigationHeader {

    // onStateUpdate should be called when changing a view based on its state.
    func onStateUpdate() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.onContentUpdate()
        }
    }

    // onContentUpdate should be called when the LanguageCoordinator updates content.
    func onContentUpdate() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self, let currentContent = LanguageCoordinator.shared.currentContent else {
                return
            }
            switch ViewController.experienceState {
            case .landing, .offering:
                // If Landing, Prep for Offering
                self.header.attributedText = Styleguide.attributedHeaderText(text: currentContent.offering.header)
                break
            case .refund:
                self.header.attributedText = Styleguide.attributedHeaderText(text: currentContent.refund.header)
                break
            }
            self.header.sizeToFit()
        }
    }
}
