// Sample Metal Shader
// For more information on libraries consult the link below
// https://developer.apple.com/metal/Metal-Shading-Language-Specification.pdf

#include "metal_stdlib"
#include "metal_math"
using namespace metal;

struct PolygonUniforms {
    float screenWidth;
    float screenHeight;
    float numberOfSides;
    float radius;
    bool isFilled;
};


// Vertex function
vertex float4 polygon_vertex_main(uint vertexID [[vertex_id]], constant PolygonUniforms &uniforms[[buffer(0)]]) {
    
    if (uniforms.isFilled) {
        bool isCenterPoint = vertexID % 3 == 0;
        if (isCenterPoint) {
            return float4(0,0,0,0);
        } else {
            // Determine triangle
            float triangleIndex = ceil(float(vertexID) / 3);
            // Determine the vertex ID
            float index = vertexID - 2*triangleIndex + 1;
            // Calculate the aspect ratio
            float aspectRatio = uniforms.screenWidth/uniforms.screenHeight;
            // Measure the radius in terms of pixels
            float polygonRadius = uniforms.radius / uniforms.screenWidth;
            // Calculate theta
            float thetaInDegrees = 360 / uniforms.numberOfSides * index;
            float thetaInRadians = thetaInDegrees * M_PI_F / 180;
            float thetaMeasured = thetaInRadians;
            
            float x = polygonRadius * sin(thetaMeasured);
            float y = polygonRadius * aspectRatio * cos(thetaMeasured);
            // Return the position as a homogeneous coordinate (with w = 1.0)
            float3 position = float3(x,y,0);
            return float4(position, 1.0);
        }
    } else {
        // Update the vertex ID
        float index = vertexID > uniforms.numberOfSides - 1 ? 0 : vertexID;
        // Calculate the aspect ratio
        float aspectRatio = uniforms.screenWidth/uniforms.screenHeight;
        // Measure the radius in terms of pixels
        float polygonRadius = uniforms.radius / uniforms.screenWidth;
        // Calculate theta
        float thetaInDegrees = 360 / uniforms.numberOfSides * index;
        float thetaInRadians = thetaInDegrees * M_PI_F / 180;
        float thetaMeasured = thetaInRadians;
        
        float x = polygonRadius * sin(thetaMeasured);
        float y = polygonRadius * aspectRatio * cos(thetaMeasured);
        // Return the position as a homogeneous coordinate (with w = 1.0)
        float3 position = float3(x,y,0);
        return float4(position, 1.0);
    }
}

// Fragment function
fragment float4 polygon_fragment_main() {
    return float4(1.0, 1.0, 1.0, 1.0);
}
