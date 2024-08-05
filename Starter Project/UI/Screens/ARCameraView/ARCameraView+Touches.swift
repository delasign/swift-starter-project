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
        toggleAnimation()
    }
    
    func toggleAnimation() {
        for child in sceneView.scene.rootNode.childNodes {
            if let key = child.childNodes.first?.animationKeys.first, let player = child.childNodes.first?.animationPlayer(forKey: key) {
                let isPlaying = !player.paused
                
                isPlaying ? player.stop() : player.play()
            }
        }
    }
}
