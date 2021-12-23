#version 300 es
precision mediump float;
in vec2 st;
uniform sampler2D heightSampler;
uniform sampler2D backgroundSampler;
out vec4 fragment;

void main() {
  vec4 backgroundSample = texture(backgroundSampler, vec2(st.s + 0.5, st.t + 0.5));
  vec4 heightSample = texture(heightSampler, vec2(st.s + 0.5, st.t + 0.5));
  fragment = vec4(heightSample.r, 0, 0, 1);
}