//
//  MetalUIView+MetalDelegate.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 10/1/23.
//

import Foundation
import UIKit
import Metal
import MetalKit

extension MetalUIView: MTKViewDelegate {
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        // Implement Custom Drawable Size will Change here
    }

    func draw(in view: MTKView) {
        // Implement Custom Drawing Logic Here
        if let drawable = view.currentDrawable,
           let renderPassDescriptor = view.currentRenderPassDescriptor,
           let device = self.metalView.device,
           let commandBuffer = device.makeCommandQueue()?.makeCommandBuffer(),
           let renderEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: renderPassDescriptor) {

            // Define the number of sides
            // Must be a var to be able to work with a buffer.
            let numberOfSides: Int = 360
            // Gather the Bounds
            let screenBounds = getCurrentScreenBounds()
            // Create the uniforms
            // Must be a variable to be able to work with a MTLBuffer.
            // For more information : https://delasign.com/blog/swift-metal-buffers/
            var uniforms: PolygonUniforms = PolygonUniforms(
                screenWidth: Float(screenBounds.width),
                screenHeight: Float(screenBounds.height),
                numberOfSides: Float(numberOfSides),
                radius: Float(250),
                isFilled: true
            )
            // Define the buffer
            guard let uniformsBuffer: MTLBuffer = device.makeBuffer(bytes: &uniforms, length: MemoryLayout<PolygonUniforms>.stride, options: []) else {
                return
            }
            // Set the buffer on the GPU.
            uniformsBuffer.label = "uniformsBuffer"
            // Pass the buffer to the vertex and fragment shader
            renderEncoder.setVertexBuffer(uniformsBuffer, offset: 0, index: 0)

            // Define the vertices of the inner circle
            renderEncoder.setRenderPipelineState(pipelineState)
            renderEncoder.drawPrimitives(
                type: uniforms.isFilled ? .triangle : .lineStrip,
                vertexStart: 0,
                vertexCount: uniforms.isFilled ? numberOfSides * 3 : numberOfSides + 1
            )

            renderEncoder.endEncoding()

            commandBuffer.present(drawable)
            commandBuffer.commit()

       }
    }

    func generateVertices(numberOfVertices: Int, radius: Float) -> [SIMD3<Float>] {
        var vertices: [SIMD3<Float>] = []
        // Add the vertices
        // Please note that each vertex has 3 points (x,y,z).

        for vertexIndex in 0...numberOfVertices {
            let theta: Double = Double(360 / numberOfVertices) * Double(vertexIndex) * Double.pi * 2
            // X
            let x: Float = radius * Float(sin(theta))
//            // Y
            let y: Float = radius * Float(cos(theta))
            // Z (Always 0)
            let z: Float = 0

            vertices.append(SIMD3<Float>(x, y, z))
        }

        return vertices
    }
}
