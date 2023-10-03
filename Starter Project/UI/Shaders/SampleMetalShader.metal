// Sample Metal Shader
// For more information on libraries consult the link below
// https://developer.apple.com/metal/Metal-Shading-Language-Specification.pdf


// Vertex function
vertex float4 sample_vertex_main(uint vertexID [[vertex_id]]) {
    // Define the vertices of the triangle
    float3 vertices[4] = {
        float3(0.0, 0.5, 0.0),   // Vertex 0: Top
        float3(-0.5, -0.5, 0.0), // Vertex 1: Bottom-left
        float3(0.5, -0.5, 0.0),  // Vertex 2: Bottom-right
        float3(0.0, 0.5, 0.0),    // Vertex 4: Close the loop
    };

    // Retrieve the vertex position for the current vertex
    float3 position = vertices[vertexID];

    // Return the position as a homogeneous coordinate (with w = 1.0)
    return float4(position, 1.0);
}

// Fragment function
fragment half4 sample_fragment_main() {
    // Define the color for the triangle (in RGBA format)
    half4 triangleColor = half4(1.0, 0.0, 0.0, 1.0); // Red color

    // Return the color for the current fragment
    return triangleColor;
}
