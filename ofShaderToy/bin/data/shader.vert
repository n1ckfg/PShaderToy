// vertex shader
// http://openframeworks.cc/ofBook/chapters/shaders.html

#version 150

uniform mat4 modelViewProjectionMatrix;
in vec4 position;

void main() {
    gl_Position = modelViewProjectionMatrix * position;
}