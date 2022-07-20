//
//  UIScrollView+UpdateContent.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 7/20/22.
//

import Foundation
import UIKit

extension UIScrollView {
    func updateContentView(offset: CGFloat? = nil) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            var addedHeight: CGFloat = 0
            if let offset = offset {
                addedHeight = offset
            }
            let maxY = self.subviews.sorted(by: { $0.frame.maxY < $1.frame.maxY }).last?.frame.maxY ?? self.contentSize.height
            self.contentSize.height = maxY + addedHeight
        }
    }
}
