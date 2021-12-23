#version 300 es
in vec2 vertexPosition;
out vec2 st;

void main() {
  gl_Position = vec4(vertexPosition, 0, 1);
  st = vertexPosition;
}
