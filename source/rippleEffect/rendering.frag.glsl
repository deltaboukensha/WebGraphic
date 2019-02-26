#version 100
precision mediump float;
varying highp vec2 st;
uniform sampler2D heightSampler;

void main() {
  float height = texture2D(heightSampler, vec2(st.s, st.t)).r;
  gl_FragColor = vec4(height, 0.0, 0.0, 1.0);
}