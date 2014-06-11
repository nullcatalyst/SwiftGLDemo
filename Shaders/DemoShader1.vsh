#version 330

uniform mat4 matrix;

in vec4 position;

void main() {
    gl_Position = matrix * position;
}
