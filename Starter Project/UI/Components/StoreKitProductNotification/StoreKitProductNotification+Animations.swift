//
//  StoreKitProductNotification+Animations.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 3/21/23.
//

import Foundation
import UIKit

extension StoreKitProductNotification {
    func animateIn() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.alpha = 0
            self.isHidden = false
            UIView.animate(withDuration: kAnimationTime) {
                self.alpha = 1
            } completion: { _ in
                // Do Nothing
            }
        }
    }

    func animateOut() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            UIView.animate(withDuration: kAnimationTime) {
                self.alpha = 0
            } completion: { _ in
                self.isHidden = true
            }
        }
    }
}
