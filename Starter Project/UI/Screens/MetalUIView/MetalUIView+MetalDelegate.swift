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
            // Gather the Bounds
            let screenBounds = getCurrentScreenBounds()
            // Draw the Shapes
            drawPolygon(encoder: renderEncoder, numberOfSides: 360, x: screenBounds.width / 2, y: screenBounds.height / 2, radius: Float(100), isFilled: true)
            drawPolygon(encoder: renderEncoder, numberOfSides: 5, x: 200, y: 200, radius: Float(250), isFilled: false)
            // End the Encoding
            renderEncoder.endEncoding()
            // Present
            commandBuffer.present(drawable)
            // Commit
            commandBuffer.commit()

       }
    }

    func drawPolygon(encoder: MTLRenderCommandEncoder, numberOfSides: Int, x: CGFloat, y: CGFloat, radius: Float, isFilled: Bool) {
        // Gather the Bounds
        let screenBounds = getCurrentScreenBounds()
        // Convert X and Y from Pixels to Metal Space
        let proportionalX = x / screenBounds.width
        let proportionalY = y / screenBounds.height
        // Normalize into metal coordinates
        let metalX: Float = Float(proportionalX * 2.0) - 1.0
        let metalY: Float = 1.0 - Float(proportionalY * 2.0)
        // Create the uniforms
        // Must be a variable to be able to work with a MTLBuffer.
        // For more information : https://delasign.com/blog/swift-metal-buffers/
        var uniforms: PolygonUniforms = PolygonUniforms(
            origin: SIMD2(x: metalX, y: metalY),
            screenWidth: Float(screenBounds.width),
            screenHeight: Float(screenBounds.height),
            numberOfSides: Float(numberOfSides),
            radius: radius,
            isFilled: isFilled
        )
        // Define the buffer
        guard let uniformsBuffer: MTLBuffer = device.makeBuffer(bytes: &uniforms, length: MemoryLayout<PolygonUniforms>.stride, options: []) else {
            return
        }
        // Set the buffer on the GPU.
        uniformsBuffer.label = "uniformsBuffer"
        // Pass the buffer to the vertex and fragment shader
        encoder.setVertexBuffer(uniformsBuffer, offset: 0, index: 0)

        // Define the vertices of the inner circle
        encoder.setRenderPipelineState(pipelineState)
        encoder.drawPrimitives(
            type: uniforms.isFilled ? .triangle : .lineStrip,
            vertexStart: 0,
            vertexCount: uniforms.isFilled ? numberOfSides * 3 : numberOfSides + 1
        )
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
