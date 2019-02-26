#version 300 es
precision mediump float;
in vec2 st;
uniform sampler2D heightSampler;
uniform sampler2D backgroundSampler;
out vec4 fragment;

void main() {
  vec4 backgroundColor = texture(backgroundSampler, vec2(st.s * 0.5 + 0.5, st.t * 0.5 + 0.5));
  float height = texture(heightSampler, vec2(st.s, st.t)).r;
  fragment = backgroundColor;
}