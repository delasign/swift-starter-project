//
//  SearchBar+Animations.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 10/5/23.
//

import Foundation
import UIKit

extension SearchBar {
    func animateIcon(color: UIColor) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            UIView.animate(withDuration: kAnimationTime) {
                self.icon.tintColor = color
            }
        }
    }
}
