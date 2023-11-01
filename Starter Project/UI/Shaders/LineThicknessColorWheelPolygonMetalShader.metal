// Line Thickness Color Wheel Polygon Metal Shader
// For more information on libraries consult the link below
// https://developer.apple.com/metal/Metal-Shading-Language-Specification.pdf

#include "Shared.h"

// Step Three: Declare the helper functions
// MARK: Helper Functions
// Declare functions before the vertex and fragment functions



// MARK: Vertex Function
// Step Four: Define the Vertex Function - it takes a PolygonUniform struct at Buffer 0.
vertex VertexOut line_thickness_color_wheel_vertex_main(uint vertexID [[vertex_id]], constant OutlinedPolygonUniforms &uniforms[[buffer(0)]]) {
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
    bool firstPass;
    float index;
    float thetaInDegrees;
    float thetaInRadians;
    float x;
    float y;
    // Calculate the triangle
    triangleIndex = floor(float(vertexID)/3) + 1;
    // Determine if its first pass or not
    firstPass = triangleIndex <= uniforms.numberOfSides;
    
    // Algorithm
    // Determine if its the first vertex of the triangle
    if (vertexID % 3 == 0) {
        // If its the first pass, then its an outside vertex
        // else its an inside vertex
        if (firstPass) {
            // Determine the index path
            index = triangleIndex - 1;
            // Determine theta
            thetaInDegrees = 360 / uniforms.numberOfSides * index;
            thetaInRadians = thetaInDegrees * M_PI_F / 180;
            // Calculate the X and Y
            x = origin.x + polygonRadius * sin(thetaInRadians);
            y = origin.y + polygonRadius * cos(thetaInRadians);
            // Determine the position
            float3 vector = float3(x,y,0);
            float3 normalizedVector = normalize(vector);
            float3 offsetVector = vector + (normalizedVector * uniforms.lineThickness/2);
            position = float3(offsetVector.x, offsetVector.y * aspectRatio, 0);
            // Determine the color
            color = lineThicknessColorWheel(thetaInDegrees);
        } else {
            // Determine the index path
            index = triangleIndex - uniforms.numberOfSides < uniforms.numberOfSides ? triangleIndex - uniforms.numberOfSides : 0;
            // Determine theta
            thetaInDegrees = 360 / uniforms.numberOfSides * index;
            thetaInRadians = thetaInDegrees * M_PI_F / 180;
            // Calculate the X and Y
            x = origin.x + polygonRadius * sin(thetaInRadians);
            y = origin.y + polygonRadius * cos(thetaInRadians);
            float3 vector = float3(x,y,0);
            float3 normalizedVector = normalize(vector);
            float3 offsetVector = vector - (normalizedVector * uniforms.lineThickness/2);
            position = float3(offsetVector.x, offsetVector.y * aspectRatio, 0);
            // Determine the color
            color = lineThicknessColorWheel(thetaInDegrees);
        }
    } else {
        // If its the first pass, these are inside vertices
        // else these are outside vertices
        if (firstPass) {
            // Determine the index path
            index = vertexID - 2*triangleIndex + 1;
            // Determine theta
            thetaInDegrees = 360 / uniforms.numberOfSides * index;
            thetaInRadians = thetaInDegrees * M_PI_F / 180;
            // Calculate the X and Y
            x = origin.x + polygonRadius * sin(thetaInRadians);
            y = origin.y + polygonRadius * cos(thetaInRadians);
            float3 vector = float3(x,y,0);
            float3 normalizedVector = normalize(vector);
            float3 offsetVector = vector - (normalizedVector * uniforms.lineThickness/2);
            position = float3(offsetVector.x, offsetVector.y * aspectRatio, 0);
            // Determine the color
            color = lineThicknessColorWheel(thetaInDegrees);
        } else {
            // Determine the index path
            index = (vertexID - 2*triangleIndex) - (uniforms.numberOfSides - 1);
            // Make sure it fits within the loop
            index = index < uniforms.numberOfSides ? index : index - uniforms.numberOfSides;
            // Determine theta
            thetaInDegrees = 360 / uniforms.numberOfSides * index;
            thetaInRadians = thetaInDegrees * M_PI_F / 180;
            // Calculate the X and Y
            x = origin.x + polygonRadius * sin(thetaInRadians);
            y = origin.y + polygonRadius * cos(thetaInRadians);
            // Determine the position
            float3 vector = float3(x,y,0);
            float3 normalizedVector = normalize(vector);
            float3 offsetVector = vector + (normalizedVector * uniforms.lineThickness/2);
            position = float3(offsetVector.x, offsetVector.y * aspectRatio, 0);
            // Determine the color
            color = lineThicknessColorWheel(thetaInDegrees);
        }
    }
    
    // Return the Vertex
    vertexOut.position = float4(position, 1.0);
    vertexOut.color = color;
    return vertexOut;
}

// MARK: Fragment Function
// Step Five: Define the Fragment Function
fragment float4 line_thickness_color_wheel_fragment_main(VertexOut vertexOut [[stage_in]]) {
    return vertexOut.color;
}