//
//  ARCameraView+Setup.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 8/5/24.
//

import Foundation
import UIKit
import ARKit

extension ARCameraView {
    func setupScene() {
        sceneView.delegate = self
        sceneView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(sceneView)
        sceneView.edgesToSuperview()
    }
    
    func addModel() {
        // Create anchor using the camera's current position
        if let currentFrame = sceneView.session.currentFrame {
            // Create a transform with a translation of 0.2 meters in front of the camera
            var translation = matrix_identity_float4x4
            translation.columns.3.z = -0.2
            let transform = simd_mul(currentFrame.camera.transform, translation)
               
            // Add a new anchor to the session
            let anchor = ARAnchor(transform: transform)
               
            guard let modelScene = SCNScene(named: "Capoeira.dae") else { return }

            // Create a node for the model
            let node = SCNNode()
              
            for child in modelScene.rootNode.childNodes {
                // Stop the animation
//                if  let key = child.animationKeys.first {
//                    child.animationPlayer(forKey: key)?.stop()
//                }
                
                let scale: Float = 0.001
                node.scale = SCNVector3(x: scale, y: scale, z: scale)
                node.addChildNode(child)
            }

            // Position the model in front of the camera
            node.position = SCNVector3(transform.columns.3.x, transform.columns.3.y, transform.columns.3.z)

            // Add the node to the scene
            sceneView.scene.rootNode.addChildNode(node)
        }
    }
}
