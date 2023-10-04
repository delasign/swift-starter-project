//
//  MetalUIView+UI.swift
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 10/1/23.
//

import Foundation
import UIKit
import Metal
import MetalKit

extension MetalUIView {

    // The setupUI function should be the only publically available class in this extension.
    // This can be called refreshUI if your app removes and adds content periodically.
    func setupUI() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.setupMetalView()
        }
    }

    private func setupMetalView() {
        device = MTLCreateSystemDefaultDevice()
        metalView = MTKView(frame: bounds, device: device)
        metalView.delegate = self
        addSubview(metalView)

        commandQueue = device.makeCommandQueue()

        let defaultLibrary = device.makeDefaultLibrary()
        let vertexFunction = defaultLibrary?.makeFunction(name: "sample_vertex_main")
        let fragmentFunction = defaultLibrary?.makeFunction(name: "sample_fragment_main")

        let pipelineDescriptor = MTLRenderPipelineDescriptor()
        pipelineDescriptor.vertexFunction = vertexFunction
        pipelineDescriptor.fragmentFunction = fragmentFunction
        pipelineDescriptor.colorAttachments[0].pixelFormat = metalView.colorPixelFormat

        do {
            pipelineState = try device.makeRenderPipelineState(descriptor: pipelineDescriptor)
        } catch {
            fatalError("Failed to create pipeline state: \(error)")
        }

    }
}
