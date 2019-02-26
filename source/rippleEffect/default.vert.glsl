#version 100
attribute vec2 vertexPosition;
varying vec2 st;

void main() {
  gl_Position = vec4(vertexPosition, 0, 1);
  st = vertexPosition;
}