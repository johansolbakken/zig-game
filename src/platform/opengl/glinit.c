#include <glad/glad.h>
#include <GLFW/glfw3.h>

int initGlad() {
    if (!gladLoadGLLoader((GLADloadproc)glfwGetProcAddress)) {
        return 1;
    }
    return 0;
}