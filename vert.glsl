// A basic vertex shader

// Input vertex position
attribute vec3 aPosition;

// Pass through to fragment shader
void main() {
    gl_Position = vec4(aPosition, 1.0);
}
