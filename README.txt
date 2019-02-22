1. Processing 
Processing can use ShaderToy shaders with only minor modifications, 
following the provided examples.

2. Unity   
It's possible to modify ShaderToy shaders for direct use in Unity, but 
only in OpenGL mode--that's not practical for most Windows desktop apps,
including for VR. Instead, use the included converter script to convert the
shader language from GLSL to CGFX, which Unity can use with both OpenGL and
DirectX. (More complex shaders will require manual correction.)

3. p5.js
Setting up a new JavaScript project takes a bit of practice, but once you get
past that, this approach is the simplest of all.

4. three.js
The boilerplate for loading shaders in three.js is a lot more complicated than in p5.js, but 
fortunately the shader code itself is no different.
 
X5. openFrameworks
TK

X6. Raspberry Pi (oF)
TK


