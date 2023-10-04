// Sample Metal Shader
// For more information on libraries consult the link below
// https://developer.apple.com/metal/Metal-Shading-Language-Specification.pdf

// -- Step One: Define the struct ---
struct ScreenSize {
    float width;
    float height;
};

// -- Step Two: Add the buffers to the vertex function ---
// The number next to the buffer must match the one that you wrote in the MetalUIView+MetalDelegate.swift
vertex float4 sample_vertex_main(uint vertexID [[vertex_id]], constant float &redBuffer[[buffer(1)]], constant ScreenSize &screenSize[[buffer(2)]]) {
    // Sample use of buffer
    float screenWidth = screenSize.width;
    float screenHeight = screenSize.width;
    // Define the vertices of the triangle
    float3 vertices[3] = {
        float3(0.0, 0.5, 0.0),   // Vertex 0: Top
        float3(-0.5, -0.5, 0.0), // Vertex 1: Bottom-left
        float3(0.5, -0.5, 0.0)   // Vertex 2: Bottom-right
    };

    // Retrieve the vertex position for the current vertex
    float3 position = vertices[vertexID];

    // Return the position as a homogeneous coordinate (with w = 1.0)
    return float4(position, 1.0);
}

// -- Step Three: Add the buffers to the Fragment function ---
// The number next to the buffer must match the one that you wrote in the MetalUIView+MetalDelegate.swift
fragment half4 sample_fragment_main(constant float &redBuffer[[buffer(1)]], constant ScreenSize &screenSize[[buffer(2)]]) {
    // Define the color for the triangle (in RGBA format)
    // !! Sample use of the refBuffer below !!
    half4 triangleColor = half4(redBuffer, 0.0, 0.0, 1.0); // Red color

    // Return the color for the current fragment
    return triangleColor;
}
