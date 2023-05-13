//
//  openURL.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 5/12/23.
//

import Foundation
import UIKit
func openURL(url: String) {
    let link = URL(string: url)!
    if UIApplication.shared.canOpenURL(link) {
        UIApplication.shared.open(link, options: [:], completionHandler: nil)
        debugPrint("UIApplication openURL \(DebuggingIdentifiers.actionOrEventSucceded) opening url : \(url)")
    } else {
        debugPrint("UIApplication openURL \(DebuggingIdentifiers.actionOrEventFailed) could not open url \(url)")
    }
}
