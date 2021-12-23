#version 300 es
precision mediump float;
in vec2 st;
uniform sampler2D heightSampler;
uniform sampler2D backgroundSampler;
out vec4 fragment;

void main() {
  vec4 backgroundColor = texture(backgroundSampler, st);
  float height = texture(heightSampler, vec2(st.s, st.t)).r;
  fragment = vec4(backgroundColor, 0, 0, 1);
}