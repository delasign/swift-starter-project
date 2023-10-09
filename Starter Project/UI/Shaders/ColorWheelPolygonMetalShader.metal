// Color Wheel Polygon Metal Shader
// For more information on libraries consult the link below
// https://developer.apple.com/metal/Metal-Shading-Language-Specification.pdf

#include "metal_stdlib"
#include "metal_math"
using namespace metal;

// Step One: Define the Uniforms Struct
// https://delasign.com/blog/swift-metal-buffers
struct PolygonUniforms {
    float screenWidth;
    float screenHeight;
    float numberOfSides;
    float radius;
    bool isFilled;
};

// Step Two: Define the Vertex Out
// https://delasign.com/blog/metal-pass-data-from-vertex-to-fragment
struct VertexOut {
    // This is required for it to function as expected
    float4 position [[position]];
    float4 color;
};

// Step Three: Declare the helper functions
// MARK: Helper Functions
// Declare functions before the vertex and fragment functions
// Please note that theta is in degrees and ranges from 0 -> 360
float4 colorWheel(float theta) {
    float normalizedTheta;
    if (theta < 120) {
        normalizedTheta = theta;
        return float4((120-normalizedTheta)/120, normalizedTheta/120, 0.0, 1.0);
    } else if (theta < 240) {
        normalizedTheta = theta - 120;
        return float4(0.0,(120-normalizedTheta)/120, normalizedTheta/120 ,1.0);
    } else {
        normalizedTheta = theta - 240;
        return float4(normalizedTheta/120, 0.0, (120-normalizedTheta)/120, 1.0);
    }
}

// MARK: Vertex Function
// Step Four: Define the Vertex Function - it takes a PolygonUniform struct at Buffer 0.
vertex VertexOut polygon_vertex_main(uint vertexID [[vertex_id]], constant PolygonUniforms &uniforms[[buffer(0)]]) {
    // Determine the constants
    float aspectRatio = uniforms.screenWidth/uniforms.screenHeight;
    float polygonRadius = uniforms.radius / uniforms.screenWidth;
    
    // Define the output variables
    float3 position;
    float4 color;
    VertexOut vertexOut;
    
    // Define the variables
    float triangleIndex;
    float index;
    float thetaInDegrees;
    float thetaInRadians;
    float x;
    float y;
    
    // Algorithm
    if (uniforms.isFilled) {
        bool isCenterPoint = vertexID % 3 == 0;
        if (isCenterPoint) {
            // Determine the position
            position = float3(0,0,0);
            // Determine the color
            color = float4(1.0,1.0,1.0,1.0);
        } else {
            // Determine triangle
            triangleIndex = ceil(float(vertexID) / 3);
            // Determine the vertex ID
            index = vertexID - 2*triangleIndex + 1;
            // Calculate theta
            thetaInDegrees = 360 / uniforms.numberOfSides * index;
            thetaInRadians = thetaInDegrees * M_PI_F / 180;
            // Calculate the X and Y
            x = polygonRadius * sin(thetaInRadians);
            y = polygonRadius * aspectRatio * cos(thetaInRadians);
            // Determine the position
            position = float3(x,y,0);
            // Determine the color
            color = colorWheel(thetaInDegrees);
        }
    } else {
        // Update the vertex ID
        index = vertexID > uniforms.numberOfSides - 1 ? 0 : vertexID;
        // Calculate the aspect ratio
        aspectRatio = uniforms.screenWidth/uniforms.screenHeight;
        // Measure the radius in terms of pixels
        polygonRadius = uniforms.radius / uniforms.screenWidth;
        // Calculate theta
        thetaInDegrees = 360 / uniforms.numberOfSides * index;
        thetaInRadians = thetaInDegrees * M_PI_F / 180;
        // Calculate the X and Y
        x = polygonRadius * sin(thetaInRadians);
        y = polygonRadius * aspectRatio * cos(thetaInRadians);
        // Determine the position
        position = float3(x,y,0);
        // Determine the color
        color = colorWheel(thetaInDegrees);
    }
    
    // Return the Vertex
    vertexOut.position = float4(position, 1.0);
    vertexOut.color = color;
    return vertexOut;
}

// MARK: Fragment Function
// Step Five: Define the Fragment Function
fragment float4 polygon_fragment_main(VertexOut vertexOut [[stage_in]]) {
    return vertexOut.color;
}
