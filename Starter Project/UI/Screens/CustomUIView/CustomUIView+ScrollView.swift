//
//  CustomUIView+ScrollView.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 8/19/22.
//

import Foundation
import UIKit

private let extensionIdentifier: String = "-- SCROLLVIEW --"

extension CustomUIView {

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        debugPrint("\(CustomUIView.identifier) \(extensionIdentifier) \(DebuggingIdentifiers.actionOrEventInProgress) scrollViewDidEndDragging \(DebuggingIdentifiers.actionOrEventInProgress) willDecelerate \(decelerate).")
    }

    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        debugPrint("\(CustomUIView.identifier) \(extensionIdentifier) \(DebuggingIdentifiers.actionOrEventInProgress) scrollViewWillBeginDecelerating \(DebuggingIdentifiers.actionOrEventInProgress).")
    }
}
