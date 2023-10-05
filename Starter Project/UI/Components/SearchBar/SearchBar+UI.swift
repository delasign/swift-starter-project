//
//  SearchBar+UI.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 10/5/23.
//
import Foundation
import UIKit
import TinyConstraints

extension SearchBar {
    // The setupUI function should be the only publically available class in this extension.
    // This can be called refreshUI if your app removes and adds content periodically.
    func setupUI() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.setupIcon()
            self.setupTextField()
        }
    }

    // MARK: UI Setup Functionality
    private func setupIcon() {
        // Set translatesAutoresizingMaskIntoConstraints to allow for constraints
        icon.translatesAutoresizingMaskIntoConstraints = false
        // Add the icon to the UIView
        addSubview(self.icon)
        // Set the constraints
        icon.left(to: self, offset: kPadding)
        icon.centerY(to: self)
        icon.width(29)
        icon.height(30)
        // Set the tint color to placeholder gray, as on initialization there is no active text
        icon.tintColor = Styleguide.colors.searchPlaceholderGray
    }

    private func setupTextField() {
        // Set translatesAutoresizingMaskIntoConstraints to allow for constraints
        textField.translatesAutoresizingMaskIntoConstraints = false
        // Add the textfield to the UIView
        addSubview(self.textField)
        // Set the constraints
        textField.leftToRight(of: self.icon, offset: kPadding)
        textField.right(to: self, offset: -kPadding)
        textField.top(to: self)
        textField.bottom(to: self)
        // Set the attributes for the active text
        textField.defaultTextAttributes = Styleguide.searchStyleAttributes(color: Styleguide.getPrimaryColor())
        // Add the textfield delegate
        textField.delegate = self
        // Add the observer for the textfield text change
        textField.addTarget(self, action: #selector(self.onTextFieldTextDidUpdate(_:)), for: .editingChanged)
    }

}
