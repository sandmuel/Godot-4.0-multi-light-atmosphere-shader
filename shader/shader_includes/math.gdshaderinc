#ifndef MATH_GDSHADERINC
#define MATH_GDSHADERINC


vec3 rotate(vec3 v, float angle, vec3 axis) {
  float s = sin(angle);
  float c = cos(angle);
  float inv_c = 1.0 - c;
  vec3 row1 = vec3(inv_c * axis.x * axis.x + c, inv_c * axis.x * axis.y - axis.z * s, inv_c * axis.z * axis.x + axis.y * s);
  vec3 row2 = vec3(inv_c * axis.x * axis.y + axis.z * s, inv_c * axis.y * axis.y + c, inv_c * axis.y * axis.z - axis.x * s);
  vec3 row3 = vec3(inv_c * axis.z * axis.x - axis.y * s, inv_c * axis.y * axis.z + axis.x * s, inv_c * axis.z * axis.z + c);
  mat3 rotationMatrix = mat3(row1, row2, row3);
  return rotationMatrix * v;
}

vec3 get_up_direction(vec3 v1, vec3 v2, vec3 v3) {
  vec3 dir1 = normalize(cross(v2 - v1, v3 - v1));
  vec3 dir2 = normalize(cross(v3 - v1, v1 - v2));
  return normalize(dir1 + dir2);
}

#endif
