//
//  SearchBar.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 10/5/23.
//

import Foundation
import UIKit

class SearchBar: UIView {
    // MARK: Variables
    static let identifier: String = "[SearchBar]"
    // Declare the keyboard state - which is initally not active (false).
    var keyboardIsActive: Bool = false
    // Declare the search state - initially pending, as search is not active till someone inputs text
    var searchState: SearchState = .pending {
        didSet {
            let color: UIColor
            switch searchState {
            case .pending:
                color = Styleguide.colors.searchPlaceholderGray
                break
            case .active:
                color = Styleguide.colors.getPrimaryColor();
                break
            }
            // Animate the icon to the new color if it isn't set already
            if self.icon.tintColor != color {
                self.animateIcon(color: color)
            }
        }
    }
    // MARK: UI
    let icon: UIImageView = UIImageView(image: UIImage(named: SystemImages.searchBarIcon)?.withRenderingMode(.alwaysTemplate))
    let textField: UITextField = UITextField()
    // MARK: Lifecycle
    // This is the function that gets called when you initialize your view.
    override init(frame: CGRect) {
        super.init(frame: frame)
        // MARK: UI Specific Setup
        // Before calling your setup functions, call any visual functionality that may be required:
        // i.e. background color, isHidden, isUserInteractionEnabled or translatesAutoresizingMaskIntoConstraints.
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = Styleguide.getBackgroundColor()
        // MARK: Functionality Setup
        self.setupUI()
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
