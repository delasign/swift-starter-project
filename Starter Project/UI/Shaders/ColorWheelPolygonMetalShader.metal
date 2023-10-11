// Color Wheel Polygon Metal Shader
// For more information on libraries consult the link below
// https://developer.apple.com/metal/Metal-Shading-Language-Specification.pdf

#include "Shared.h"

// MARK: Vertex Function
// Step Four: Define the Vertex Function - it takes a PolygonUniform struct at Buffer 0.
vertex VertexOut color_wheel_vertex_main(uint vertexID [[vertex_id]], constant PolygonUniforms &uniforms[[buffer(0)]]) {
    // Determine the constants
    float aspectRatio = uniforms.screenWidth/uniforms.screenHeight;
    float polygonRadius = uniforms.radius / uniforms.screenWidth;
    float2 origin = uniforms.origin;
    
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
            position = float3(origin.x,origin.y,0);
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
            x = origin.x + polygonRadius * sin(thetaInRadians);
            y = origin.y + polygonRadius * aspectRatio * cos(thetaInRadians);
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
        x = origin.x + polygonRadius * sin(thetaInRadians);
        y = origin.y + polygonRadius * aspectRatio * cos(thetaInRadians);
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
fragment float4 color_wheel_fragment_main(VertexOut vertexOut [[stage_in]]) {
    return vertexOut.color;
}
