//
//  ARCameraView+Touches.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 8/4/24.
//

import Foundation
import ARKit
import UIKit

extension ARCameraView {
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        addModel()
    }
    
    func addModel() {
        debugPrint("Add Model")
    }
}
