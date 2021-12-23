#version 300 es
precision mediump float;
in vec2 st;
uniform sampler2D heightSampler;
uniform sampler2D backgroundSampler;
out vec4 fragment;

void main() {
  vec4 backgroundSample = texture(backgroundSampler, st);
  vec4 heightSample = texture(heightSampler, st);
  fragment = vec4(backgroundSample, 0, 0, 1);
}