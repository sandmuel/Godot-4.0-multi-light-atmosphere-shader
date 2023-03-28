shader_type spatial;
render_mode cull_front, unshaded, depth_test_disabled;


#include "shader_includes/ray_sphere_intersection.gdshaderinc"


//main parameters
uniform float atmo_radius = 0.5;
uniform float atmo_density: hint_range(0, 1) = 0.5;

//varying
varying vec3 cam_pos;
varying vec3 cam_dir;
varying float frag_z;


void fragment() {
	//update some varying values
	cam_pos = VIEW_MATRIX[3].xyz;
	cam_dir = VIEW;
	frag_z = FRAGCOORD.z;

	//alpha calculations
	vec2 si = get_t1_and_t2(atmo_radius, cam_pos, cam_dir);
	ALPHA = clamp(si.y-si.x, 0, 1);
}
