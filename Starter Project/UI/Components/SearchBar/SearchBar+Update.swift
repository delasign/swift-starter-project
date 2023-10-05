//
//  SearchBar+Update.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 10/5/23.
//

import Foundation
import UIKit

extension SearchBar {
    // onContentUpdate should be called when the LanguageCoordinator updates content.
    func onContentUpdate() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self, let currentContent = LanguageCoordinator.shared.currentContent else {
                debugPrint("\(SearchBar.identifier) \(DebuggingIdentifiers.actionOrEventFailed) Failed to update content, either the custom view does not exist or the current content is not available.")
                return
            }
            // Update SearchBar Placeholder Attributed Text
            self.textField.attributedPlaceholder = Styleguide.attributedSearchStyleText(text: currentContent.searchBar.search, color: Styleguide.colors.searchPlaceholderGray)
            debugPrint("\(SearchBar.identifier) \(DebuggingIdentifiers.actionOrEventSucceded) Updated Content!")
        }
    }

    func dismissKeyboard() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.textField.resignFirstResponder()
        }
    }

}
