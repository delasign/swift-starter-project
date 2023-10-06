// Polygon Metal Shader
// For more information on libraries consult the link below
// https://developer.apple.com/metal/Metal-Shading-Language-Specification.pdf

#include "metal_stdlib"
#include "metal_math"
using namespace metal;

// Step One: Define the Uniforms Struct
struct PolygonUniforms {
    float screenWidth;
    float screenHeight;
    float numberOfSides;
    float radius;
    bool isFilled;
};

struct VertexOut {
    // This is required for it to function as expected
    float4 position [[position]];
    float3 vertexPosition;
    float4 color;
    float radius;
};


// Step Two: Define the Vertex Function - it takes a PolygonUniform struct at Buffer 0.
vertex VertexOut polygon_vertex_main(uint vertexID [[vertex_id]], constant PolygonUniforms &uniforms[[buffer(0)]]) {
    
    if (uniforms.isFilled) {
        bool isCenterPoint = vertexID % 3 == 0;
        if (isCenterPoint) {
            float3 position = float3(0,0,0);
            VertexOut vertexOut;
            vertexOut.position = float4(position, 1.0);
            vertexOut.vertexPosition = position;
            vertexOut.radius = uniforms.radius;
            vertexOut.color = float4(0,0,0,0.0);
            return vertexOut;
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
            float4 color;
            if (index == 1) {
                color = float4(1.0,0.0,0.0,1.0);
            } else if (index == 2) {
                color = float4(0.0,1.0,0.0,1.0);
            } else {
                color = float4(0.0,0.0,1.0,1.0);
            }
            // Define and return the vertex
            VertexOut vertexOut;
            vertexOut.position = float4(position, 1.0);
            vertexOut.vertexPosition = position;
            vertexOut.radius = uniforms.radius;
            vertexOut.color = color;
            return vertexOut;
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
        float fraction = 255/uniforms.numberOfSides;
        // Define and return the vertex
        VertexOut vertexOut;
        vertexOut.position = float4(position, 1.0);
        vertexOut.vertexPosition = position;
        vertexOut.radius = uniforms.radius;
        vertexOut.color = float4(fraction,fraction,fraction,1.0);;
        return vertexOut;
    }
}

// Step Three: Define the Fragment Function
fragment float4 polygon_fragment_main(VertexOut vertexOut [[stage_in]]) {
    return vertexOut.color;
}
