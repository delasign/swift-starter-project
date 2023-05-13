//
//  UIView+SizeToFit.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 4/12/23.
//

import Foundation
import UIKit

extension UIView {
    func getHeightOfContent() -> CGFloat {
        var height: CGFloat = 0
        for view in self.subviews {
            if view.frame.maxY > height {
                height = view.frame.maxY
            }
        }
        return height
    }

    func getWidthOfContent() -> CGFloat {
        var width: CGFloat = 0
        for view in self.subviews {
            if view.frame.maxX > width {
                width = view.frame.maxX
            }
        }
        return width
    }
}
