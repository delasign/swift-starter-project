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

            renderEncoder.setRenderPipelineState(pipelineState)
            renderEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
            
            
            // Define the variable buffer
            var red: Float = 0.5;
            // Define the buffer
            guard let redBuffer: MTLBuffer = device.makeBuffer(bytes: &red, length: MemoryLayout<Float>.stride, options: []) else { return
            }
            
            // Set the buffer on the GPU.
            redBuffer.label = "redBuffer"
            // Pass the buffer to the vertex and fragment shader
            renderEncoder.setVertexBuffer(redBuffer, offset: 0, index: 1)
            renderEncoder.setFragmentBuffer(redBuffer, offset: 0, index: 1)
            

            // Define the struct
            // Please note this should fall within its own file in the Models folder
            struct ScreenSize {
                let width: Float
                let height: Float
            }
            
            var screenSizeData: ScreenSize = ScreenSize(width: Float(self.bounds.width), height: Float(self.bounds.height))
            // Define the buffer
            guard let screenSizeBuffer: MTLBuffer = device.makeBuffer(bytes: &screenSizeData, length: MemoryLayout<ScreenSize>.stride, options: []) else {
                return
            }
            // Set the buffer on the GPU.
            screenSizeBuffer.label = "ScreenSizeBuffer"
            // Pass the buffer to the vertex and fragment shader
            renderEncoder.setVertexBuffer(screenSizeBuffer, offset: 0, index: 2)
            renderEncoder.setFragmentBuffer(screenSizeBuffer, offset: 0, index: 2)

//            renderEncoder.setVertexBuffer(constantsBuffer, offset: 0, index: 1)
            renderEncoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: 3)
            renderEncoder.endEncoding()

            commandBuffer.present(drawable)
            commandBuffer.commit()

       }
    }
}
