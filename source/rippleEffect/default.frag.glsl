#version 100
precision mediump float;
varying vec2 st;

#define sphereCount 2
#define sphereRadius 1
#define cameraFocal 4
#define backgroundColor vec3(0.1, 0.2, 0.3)
#define floatMax +1000000.0
#define floatMin -1000000.0
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
float intersectSphere(vec3 rayPosition, vec3 rayDirection, vec3 spherePosition){
  float a = dot(rayDirection, rayDirection);
  float x = rayPosition - spherePosition;
  float b = dot(2.0 * rayDirection, x);
  float c = dot(x, x) - sphereRadius * sphereRadius;
  float d = b * b - 4 * a * c;
  float e = sqrt(d);
  float t0 = (-b + e) / (2 * a);
	float t1 = (-b - e) / (2 * a);

  if(d <= 0)
	{
    return rayMiss;
  }

  float t_min = 0.001f;
    
  //always two hits, straight through the sphere
  if(t0 <= t_min && t1 <= t_min) //both are behind camera
    return rayMiss;
  else if( t0 <= t_min ) //one behind camera
    return t1;
  else if( t1 <= t_min ) //one behind camera
    return t0;
  else //choose the closest one
    return min(t0, t1);
}

void main() {
  load();
  vec3 rayPosition = cameraPosition;
  vec3 rayDirection = cameraRotation * vec3(st, cameraFocal);

  float rayMagnitude = intersectSphere(rayPosition, rayDirection, spherePosition[0]);
  gl_FragColor = vec4(st.s, st.t, 0.0, 1.0);
}