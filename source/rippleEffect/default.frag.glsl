#version 100
precision mediump float;
varying highp vec2 st;
uniform sampler2D heightSampler;

void main() {
  gl_FragColor = vec4(st.s, st.t, 0.0, 1.0);
}