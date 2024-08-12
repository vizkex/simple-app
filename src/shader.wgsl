struct VertexInput {
    @location(0) position: vec2<f32>,
};

struct VertexOutput {
    @builtin(position) clip_position: vec4<f32>,
    @location(0) uv: vec2<f32>,
};

@vertex
fn vs_main(in: VertexInput) -> VertexOutput {
    var out: VertexOutput;
    out.clip_position = vec4<f32>(in.position, 0.0, 1.0);
    out.uv = (in.position + 1.0) / 2.0;
    return out;
}

@fragment
fn fs_main(in: VertexOutput) -> @location(0) vec4<f32> {
    let resolution = vec2<f32>(800.0, 600.0); // Adjust to your canvas size
    let uv = in.uv;
    
    let rect_pos = vec2<f32>(0.25, 0.25);
    let rect_size = vec2<f32>(0.5, 0.3);
    let corner_radius = 0.10;
    
    let color = vec4<f32>(1.0, 0.5, 0.2, 1.0); // Rectangle color
    let background = vec4<f32>(0.1, 0.1, 0.1, 1.0); // Background color
    
    if (rounded_rect(uv, rect_pos, rect_size, corner_radius)) {
        return color;
    } else {
        return background;
    }
}

fn rounded_rect(uv: vec2<f32>, pos: vec2<f32>, size: vec2<f32>, radius: f32) -> bool {
    let dist = abs(uv - pos) - size + vec2<f32>(radius);
    let outer_dist = length(max(dist, vec2<f32>(0.0)));
    let inner_dist = min(max(dist.x, dist.y), 0.0);
    return (outer_dist + inner_dist) < radius;
}