#include "lib/curvature.glsl"
void inceptionProject() {
#if MCOSE_ENABLED
    // Explicit renderer draw-role flag: never alter the hand, HUD, sky or menus.
    if ((int(pushData.params0.y) & 32) == 0) return;
    // Built-in vertices have already converted OpenGL clip to Vulkan clip.
    // Recover the homogeneous position BEFORE the perspective divide. This also
    // works for procedural weather and clouds whose worldFromLocal is tint data.
    vec4 clip = gl_Position;
    clip.y = -clip.y;
    clip.z = 2.0 * clip.z - clip.w;
    vec4 world = shadowData.worldFromCameraClip * clip;
    if (abs(world.w) < 0.000001) return;
    vec3 position = world.xyz / world.w;
    vec3 relative = position - shadowData.cameraPosition.xyz;
    vec3 bent = inceptionBend(relative);
    // Use the bent distance for cloud visibility; an upward curve can cross the
    // far plane long before its original horizontal distance reaches the fog.
    if (pushData.params0.x > 2.5) fragFogCoord = length(bent);
    // Add a displacement, preserving the original homogeneous position and jitter.
    clip += shadowData.cameraFromWorld * vec4(bent - relative, 0.0) * world.w;
    clip.y = -clip.y;
    clip.z = (clip.z + clip.w) * 0.5;
    gl_Position = clip;
#endif
}
