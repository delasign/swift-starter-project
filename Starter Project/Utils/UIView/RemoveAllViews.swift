//
//  RemoveAllViews.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 3/9/23.
//

import Foundation
import UIKit

extension UIView {
    func removeAllViews() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            for subview in self.subviews {
                subview.removeFromSuperview()
            }
        }
    }
}
