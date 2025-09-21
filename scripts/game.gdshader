shader_type canvas_item;

uniform vec2 hole_center = vec2(0.5, 0.5);
uniform float hole_radius : hint_range(0.0, 1.0) = 0.25;
uniform float edge_feather : hint_range(0.0, 0.5) = 0.05;
uniform float overlay_alpha : hint_range(0.0, 1.0) = 1.0;

void fragment() {
    vec2 uv = SCREEN_UV;
    float dist = distance(uv, hole_center);



    float hole_edge_inner = hole_radius - edge_feather;
    float hole_edge_outer = hole_radius;
    
	
    float t = smoothstep(hole_edge_inner, hole_edge_outer, dist);

   
    vec4 black = vec4(0.0, 0.0, 0.0, overlay_alpha);
    
	
    COLOR = black * t;
}
