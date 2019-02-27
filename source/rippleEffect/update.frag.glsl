#version 300 es
precision mediump float;
in vec2 st;
uniform sampler2D heightSampler;
out vec4 fragment;

void main() {
  float height = texture(heightSampler, vec2(st.s+0.1, st.t+0.1)).r;
  fragment = vec4(height, 0, 0, 1);
}