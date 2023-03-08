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
            let imageName: String
            switch ViewController.experienceState {
            case .landing:
                // Do Nothing, it will be animated out
                imageName = ""
                break
            case .offering:
                imageName = Images.back

                break
            case .refund:
                imageName = Images.exit
                break
            }
            self.symbol.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
        }
    }
}
