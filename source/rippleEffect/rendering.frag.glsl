#version 300 es
precision mediump float;
in vec2 st;
uniform sampler2D heightSampler;
out vec4 fragment;

void main() {
  float height = texture(heightSampler, vec2(st.s, st.t)).r;
  fragment = vec4(height, 0.0, 0.0, 1.0);
}