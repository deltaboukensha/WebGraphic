#version 300 es
precision mediump float;
in vec2 st;
out vec4 fragment;

uniform vec2 click;

void main() {
  vec2 center = vec2(0, 0);
  float distanceToCenter = distance(center, st);
  fragment = vec4(1.0 - distanceToCenter * 10.0, 0, 0, 1);
}