# Inception

An original upward world-curvature shader inspired by the supplied classic Minecraft
video stills. Terrain, water, entities, block entities, particles, selection outlines,
rain, snow, lightning and clouds share one camera-relative world-space bend. The sky,
first-person hand and HUD remain steady. This is a visual effect: collisions and
block interaction still use the original world.

Enable this resource pack above other shader packs, choose **Inception** (or **Auto**)
in Video Settings → Shaders, and turn on **Enable this shader pack**. The pack selects its renderer internally
and has no Vintage/RT effect controls. Requires the Oldschool client with shader
manifest format 3 and subdivided curved clouds (September 2026)
and the Vulkan renderer. This is not an OptiFine/Iris pack.

World Curvature controls:
- **World Bend** enables the effect.
- **Bend Radius**: lower is stronger; default 48 blocks, range 16–512.
- **Flat Distance**: nearby undistorted area; default 8 blocks.
- **Bend Shape**: all directions, East / West, or North / South.
- **Bend Direction**: upward (Inception) or downward.

The curve adds `max(horizontalDistance - flatDistance, 0)^2 / (2 * radius)`
to world height relative to the camera, identically for every world draw. Clouds
use their real transformed position, independent of their scrolling texture and
the weather-colour payload. No shader copies of the engine's lighting code are needed.

Ordinary straight-world frustum, section-occlusion and GPU occlusion/backface
shortcuts are bypassed while a deforming pack is active. Strong curvature therefore
costs more draw work. Built-in lighting remains attached to the original world;
planar/reflection captures and ray-traced geometry are not themselves deformed.
This pack starts with lighting effects and reflections disabled for the classic-video look.
Fancy clouds share matching surface/side vertices and retain both horizontal faces
so strong bends remain joined when viewed from below or above the cloud layer.

Cloud meshes retain their complete subdivided geometry at all view distances.
Cloud opacity fades with the bent distance before the finite mesh/far-plane edge;
this cloud-only fade remains active when terrain fog is set to zero.

Bend Radius and Flat Distance use draggable sliders with the shader-slider client.
Their labels preview the snapped value during dragging; releasing applies it.
Arrow keys adjust one step, and Home/End select the endpoints after focusing.
