// Sample Metal Shader
// For more information on libraries consult the link below
// https://developer.apple.com/metal/Metal-Shading-Language-Specification.pdf

// --- Step One: Create the VertexOut Struct ---
struct VertexOut {
    // This is required for it to function as expected
    float4 position [[position]];
    // This is the way that we pass down a vertex position that works as expected
    float3 vertexPosition;
};

// --- Step Two: Update the vertex function to include the vertex out as the return and add the code required to execute it ---
vertex VertexOut sample_vertex_main(uint vertexID [[vertex_id]]) {
    // Define the vertices of the triangle
    float3 vertices[3] = {
        float3(0.0, 0.5, 0.0),   // Vertex 0: Top
        float3(-0.5, -0.5, 0.0), // Vertex 1: Bottom-left
        float3(0.5, -0.5, 0.0)   // Vertex 2: Bottom-right
    };

    // Retrieve the vertex position for the current vertex
    float3 position = vertices[vertexID];
    
    // Create the vertex out, assign its parameters and return it
    VertexOut outVertex;
    outVertex.position = float4(position, 1.0);
    outVertex.vertexPosition = position;
    return outVertex;
}
// --- Step Three: Update the fragment function to include the vertex out as an argument and change the color based on values from the vertex out ---
fragment float4 sample_fragment_main(VertexOut vertexOut [[stage_in]]) {
    // Use the interpolated color value from the vertex shader
    if (vertexOut.vertexPosition.y > 0.0) {
        return float4(1.0, 0.0, 0.0, 1.0); // Red color
    } else {
        return float4(1.0, 1.0, 1.0, 1.0); // White color
    }
}
