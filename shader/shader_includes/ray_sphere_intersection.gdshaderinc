#ifndef RAY_SPHERE_INTERSECTION_GDSHADERINC
#define RAY_SPHERE_INTERSECTION_GDSHADERINC


vec3 vec_from_ray_dist(vec3 ray_origin, vec3 ray_dir, float dist) {
	return ray_origin+(ray_dir*dist);
}

vec2 get_t1_and_t2(vec3 atmo_center, float radius, vec3 ray_origin, vec3 ray_dir) {
	//NOTE: the "t"s are distances from ray_origin to the matching "p"s

	/**********************************************************************************************************/
	/* get the point between the first intersection and the last, then find the distance to the intersections */
	/**********************************************************************************************************/

	//get the distance (t) from ray_origin to p
	vec3 ray_to_center = atmo_center-ray_origin; //vector from ray origin to the atmosphere's center
	float t = dot(ray_to_center, ray_dir); //distance (from ray_origin) to p

	//get p and it's distance to p1 and p2
	vec3 p = vec_from_ray_dist(ray_origin, ray_dir, t); //point between the first and last intersection points
	float center_to_p_length = length(atmo_center-p); //distance from the center to p
	//value below is found based on circle formula
	float p_dist_from_intersections = sqrt(pow(radius, 2)-pow(center_to_p_length, 2)); //dist from p to p1 and p2

	/***********************************/
	/* get p1 and p2, then return them */
	/***********************************/

	//default to 0
	float t1 = 0.0;
	float t2 = 0.0;

	//get the distances to the points *only* if the point is in the atmosphere
	if (center_to_p_length<radius) {
		//max to avoid points behind the camera
		t1 = max(t-p_dist_from_intersections, 0); //substract the distance (distance to the intersection from t)
		t2 = t+p_dist_from_intersections; //add the distance (distance to the intersection from t)
	}

	return vec2(t1, t2); //this doesn't need explaining ;)
}


#endif
