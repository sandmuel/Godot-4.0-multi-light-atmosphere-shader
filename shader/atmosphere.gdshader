shader_type spatial;
render_mode cull_front, unshaded;


#include "density_calculations.gdshaderinc"


//main parameters
uniform float atmo_radius = 0.5;
uniform float atmo_density: hint_range(0, 1) = 0.5;

//extra parameters
uniform sampler2D blue_noise;

//universal values
varying vec3 cam_pos;
varying vec3 p2;

//temp parameters
uniform vec3 light_dir = vec3(0, 0, -1);


void vertex() {
	//update varying values
	cam_pos = CAMERA_POSITION_WORLD;
	p2 = VERTEX;
}

void fragment() {
	vec3 p1 = get_p1(atmo_radius, cam_pos, p2);
	float density = density_calc(atmo_density, p1, p2);

	//albedo calculations
	ALBEDO = p1;

	//alpha calculations
	//ALPHA = visible_atmo_alpha_calc(density);
}
