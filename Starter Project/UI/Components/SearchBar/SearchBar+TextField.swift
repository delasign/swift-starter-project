//
//  SearchBar+TextField.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 10/5/23.
//

import Foundation
import UIKit

extension SearchBar: UITextFieldDelegate {
    // When a user presses enter dismiss the keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.dismissKeyboard()
        return true
    }

    // MARK: Text Editing Functionality
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.keyboardIsActive = true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        self.keyboardIsActive = false
    }

    // MARK: TextField Update Functionality
    @objc func onTextFieldTextDidUpdate(_ textField: UITextField) {
        debugPrint("\(SearchBar.identifier) onTextFieldTextDidUpdate \(DebuggingIdentifiers.actionOrEventSucceded) \(textField.text)")
        switch textField.text {
        case .none, "":
            self.searchState = .pending
            break
        default:
            self.searchState = .active
        }
        // Send the Notification
        NotificationCoordinator.shared.sendOnSearchQueryWasUpdated()
    }
}
