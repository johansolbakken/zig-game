#shader vertex
#version 410 core

layout (location = 0) in vec3 position;

void main() {
    gl_Position = vec4(position, 1.0);
}

#shader fragment
#version 410 core

out vec4 color;

void main() {
    color = vec4(1.0f, 0.5f, 0.2f, 1.0f);
}
