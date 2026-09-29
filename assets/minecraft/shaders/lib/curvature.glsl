// One camera-relative WORLD-space curve for terrain, models, particles and clouds.
// The height change depends only on horizontal distance, never camera pitch or
// object-local coordinates. Nearby geometry remains flat with a smooth join.
vec3 inceptionBend(vec3 relativeWorld) {
#if MCOSE_ENABLED
#if MCOSE_SHAPE == 1
    float distanceFromEye = abs(relativeWorld.x);
#elif MCOSE_SHAPE == 2
    float distanceFromEye = abs(relativeWorld.z);
#else
    float distanceFromEye = length(relativeWorld.xz);
#endif
    float distancePastFlat = max(distanceFromEye - float(MCOSE_START), 0.0);
    float lift = distancePastFlat * distancePastFlat / (2.0 * float(MCOSE_RADIUS));
#if MCOSE_DIRECTION == 1
    lift = -lift;
#endif
    relativeWorld.y += lift;
#endif
    return relativeWorld;
}
