#version 450
#define main inceptionBuiltinMain
#include <builtin>
#undef main
// Prefix of the renderer's set 3 binding 0 ABI (weather has no lighting inputs).
layout(set = 3, binding = 0) uniform InceptionCamera {
    mat4 lightFromCameraClip;
    mat4 worldFromCameraClip;
    mat4 lightFromWorld;
    mat4 cloudLightFromWorld;
    mat4 cameraFromWorld;
    vec4 params;
    vec4 emissiveMeta;
    vec4 environmentMeta;
    vec4 sunDirection;
    vec4 cameraPosition;
} shadowData;
#include "lib/project.glsl"
void main() {
    inceptionBuiltinMain();
    // Inactive procedural vertices must remain clipped and transparent.
    if (fragColor.a > 0.0) inceptionProject();
}
