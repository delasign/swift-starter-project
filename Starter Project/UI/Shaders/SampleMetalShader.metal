// Sample Metal Shader
// For more information on libraries consult the link below
// https://developer.apple.com/metal/Metal-Shading-Language-Specification.pdf

// Define the struct
struct ScreenSize {
    float width;
    float height;
};

// Vertex function
vertex float4 sample_vertex_main(uint vertexID [[vertex_id]], constant ScreenSize &screenSize[[buffer(1)]]) {
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

// Fragment function
fragment half4 sample_fragment_main(constant ScreenSize &screenSize[[buffer(1)]]) {
    // Define the color for the triangle (in RGBA format)
    half4 triangleColor = half4(1.0, 0.0, 0.0, 1.0); // Red color

    // Return the color for the current fragment
    return triangleColor;
}
