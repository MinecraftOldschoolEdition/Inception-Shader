#version 450
#define main inceptionBuiltinMain
#include <builtin>
#undef main
void main() {
    inceptionBuiltinMain();
#if MCOSE_ENABLED
    // Keep the fogged cloud edge transparent against the actual sky. The same
    // discard runs in Fancy's depth and color passes, avoiding an invisible wall.
    if (pushData.params0.x > 2.5 && (int(pushData.params0.y) & 32) != 0
            && (int(pushData.params0.y) & 1) != 0) {
        float visibility;
        if (pushData.params0.z < 1.5) {
            visibility = clamp((pushData.fogParams.y - fragFogCoord)
                / max(0.0001, pushData.fogParams.y - pushData.fogParams.x), 0.0, 1.0);
        } else {
            float amount = max(0.0, pushData.fogParams.z) * fragFogCoord;
            visibility = exp(-(pushData.params0.z < 2.5 ? amount : amount * amount));
        }
        outColor.a *= visibility;
        if (outColor.a <= 1.0 / 255.0) discard;
    }
#endif
}
