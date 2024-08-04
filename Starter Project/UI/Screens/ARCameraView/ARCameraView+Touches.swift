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
        addCube()
    }
    
    func addCube() {
        // Create anchor using the camera's current position
        if let currentFrame = sceneView.session.currentFrame {
            
            // Create a transform with a translation of 0.2 meters in front of the camera
            var translation = matrix_identity_float4x4
            translation.columns.3.z = -0.2
            let transform = simd_mul(currentFrame.camera.transform, translation)
            
            // Add a new anchor to the session
            let anchor = ARAnchor(transform: transform)
            
            let cube = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0)
            // Create a material
            let material = SCNMaterial()
            material.diffuse.contents = UIColor.blue
            cube.materials = [material]

            // Create a node with the cube geometry
            let cubeNode = SCNNode(geometry: cube)

            // Position the cube in front of the camera
            cubeNode.position = SCNVector3(transform.columns.3.x, transform.columns.3.y, transform.columns.3.z)

            // Add the cube node to the scene
            sceneView.scene.rootNode.addChildNode(cubeNode)
        }
    }
}
