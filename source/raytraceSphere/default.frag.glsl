#version 100
precision mediump float;
varying vec2 st;

#define sphereCount 2
#define sphereRadius 1
#define cameraFocal 4
#define backgroundColor vec3(0.1, 0.2, 0.3)
#define floatMax 3.402823466e+38
#define floatMin 1.175494351e-38
#define rayMiss floatMin

vec3 cameraPosition = vec3(0,0,0);
mat3 cameraRotation;

vec3 spherePosition[sphereCount];
vec4 sphereColor[sphereCount];

void load(){
  spherePosition[0] = vec3(0.0, 0.0, 10.0);
  spherePosition[1] = vec3(0.0, 0.0, 20.0);
  sphereColor[0] = vec4(0.0, 1.0, 0.0, 1.0);
  sphereColor[1] = vec4(0.0, 0.0, 1.0, 1.0);
}

// returns the rayMagnitude where it intersected the sphere or rayMiss
float intersectSphere(vec3 rayPosition, vec3 rayDirection, int sphereIndex){
  vec3 p = spherePosition[0];
  
  return rayMiss;
}

void main() {
  load();
  vec3 rayPosition = cameraPosition;
  vec3 rayDirection = cameraRotation * vec3(st, cameraFocal);

  float rayMagnitude = intersectSphere(rayPosition, rayDirection, 0);
  gl_FragColor = vec4(st.s, st.t, 0.0, 1.0);
}