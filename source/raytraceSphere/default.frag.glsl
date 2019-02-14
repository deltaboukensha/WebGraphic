#version 100
precision mediump float;
varying vec2 st;

#define sphereCount 2

vec3 spherePosition[sphereCount];
vec4 sphereColor[sphereCount];

void main() {
  spherePosition[0] = vec3(0.0, 0.0, 10.0);
  spherePosition[1] = vec3(0.0, 0.0, 20.0);
  sphereColor[0] = vec4(0.0, 1.0, 0.0, 1.0);
  sphereColor[1] = vec4(0.0, 0.0, 1.0, 1.0);

  gl_FragColor = vec4(st.s, st.t, 0.0, 1.0);
}