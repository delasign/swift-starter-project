//
//  UpdateSafeAreaInsets.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 7/20/22.
//

import Foundation
import UIKit

func updateSafeAreaInsets(topConstraint: NSLayoutConstraint?, rightConstraint: NSLayoutConstraint?, bottomConstraint: NSLayoutConstraint?, leftConstraint: NSLayoutConstraint?) {
    DispatchQueue.main.async {
        topConstraint?.constant = ViewController.safeAreaInsets.top
        rightConstraint?.constant = -ViewController.safeAreaInsets.right
        bottomConstraint?.constant = -ViewController.safeAreaInsets.bottom
        leftConstraint?.constant = ViewController.safeAreaInsets.left
    }
}
