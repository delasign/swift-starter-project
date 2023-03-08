//
//  NavigationButton+Update.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 3/8/23.
//

import Foundation
import UIKit

extension NavigationButton {

    // onStateUpdate should be called when changing a view based on its state.
    func onStateUpdate() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            switch ViewController.experienceState {
            case .landing:
                // Do Nothing, it will be animated out
                break
            case .offering:
                self.symbol.image = UIImage(named: Images.back)
                break
            case .refund:
                self.symbol.image = UIImage(named: Images.exit)
                break
            }
        }
    }
}
