#ifndef DENSITY_CALCULATIONS_GDSHADERINC
#define DENSITY_CALCULATIONS_GDSHADERINC


#include "math.gdshaderinc"


vec3 get_p1(float atmo_radius, vec3 cam_pos, vec3 p2) {
	vec3 p2_to_cam = normalize(cam_pos-p2); //vector representing the direction from p2 to the camera
	vec3 p2_to_center = vec3(0)-p2; //vector representing the direction from p2 to the center
	vec3 up_dir = get_up_direction(cam_pos, vec3(0), normalize(p2)); //up dir, for use as the vector to rotate around
	
	float angle = acos(dot(p2_to_cam, p2_to_center)); //the angle between p2_to_cam and p2_to_center in radians

	vec3 p1 = rotate(normalize(p2_to_center), angle, up_dir)*atmo_radius;

	//return the smaller one
	if (distance(cam_pos, vec3(0)) < distance(p1, vec3(0))) {
		return cam_pos;
	}
	return p1;
}

float density_calc(float atmo_density, vec3 p1, vec3 p2) {
	vec3 p3 = (p1+p2)/2.0; //get the point between p1 and p2
	float dist_from_center = 1.0-distance(p3, vec3(0)); //get p3's distance from the center, inverted
	return clamp(dist_from_center, 0, 1)*atmo_density;
}

float visible_atmo_alpha_calc(float density) {
	float visible_atmo = clamp(density, 0, 1);
	return visible_atmo; //give clamped density*radius
}

#endif
