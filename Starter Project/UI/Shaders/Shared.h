//
//  Shared.h
//  Starter Project
//
//  Created by Oscar de la Hera Gomez on 10/11/23.
//

// MARK: Pragma
// Use the pragma once mark to ensure that this header file is only included once.
#pragma once
// MARK: Add the Libraries
#include <metal_stdlib>
#include "metal_math"
// MARK: Define the Namespace
using namespace metal;

// MARK: Constants
constant float sampleFloat = 0;

// MARK: Uniform & Argument Structs
// https://delasign.com/blog/swift-metal-buffers
struct PolygonUniforms {
    float2 origin;
    float screenWidth;
    float screenHeight;
    float numberOfSides;
    float radius;
    bool isFilled;
};

struct OutlinedPolygonUniforms {
    float2 origin;
    float screenWidth;
    float screenHeight;
    float numberOfSides;
    float radius;
    float lineThickness;
};

// MARK: Vertex Out Structs
// https://delasign.com/blog/metal-pass-data-from-vertex-to-fragment
struct VertexOut {
    // This is required for it to function as expected
    float4 position [[position]];
    float4 color;
};

// MARK: Functionality
// Please note that theta is in degrees and ranges from 0 -> 360
float4 colorWheel(float theta);
// Please note that theta is in degrees and ranges from 0 -> 360
float4 inverseColorWheel(float theta);
// Please note that theta is in degrees and ranges from 0 -> 360
float4 lineThicknessColorWheel(float theta);
