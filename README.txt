1. Processing
Processing can use ShaderToy shaders directly, without modification.

2. Unity It's possible for Unity to use ShaderToy shaders directly, but only in
OpenGL mode, which won't work for most Windows desktop apps, including for VR.
Instead, use the included converter script to convert the shaders from GLSL to
CGFX, which Unity can use with both OpenGL and DirectX.

X3. three.js
TBD
