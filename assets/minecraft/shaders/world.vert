#version 450
#define main inceptionBuiltinMain
#include <builtin>
#undef main
#include "lib/project.glsl"
void main() {
    inceptionBuiltinMain();
    inceptionProject();
}
