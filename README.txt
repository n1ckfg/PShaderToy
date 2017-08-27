1. Processing 
Processing can use ShaderToy shaders with only minor modifications, 
following the provided examples.

2. Unity   
It's possible to modify ShaderToy shaders for direct use in Unity, but 
only in OpenGL mode--that's not practical for most Windows desktop apps,
including for VR. Instead, use the included converter script to convert the
shader language from GLSL to CGFX, which Unity can use with both OpenGL and
DirectX. (More complex shaders will require manual correction.)

X3. three.js
TBD
