### 1. Processing: PShaderToy
<i>ShaderToy shaders work with minor changes.</i> If you have no prior experience with any of these approaches, Processing can probably get you up and running with shaders the fastest.

### 2. p5.js: p5jsShaderToy
<i>ShaderToy shaders work with minor changes.</i> Currently shaders don't work in the p5.js Web Editor, and setting up a new JavaScript project can take a bit of practice. So if you've written some JS before, start here.

### 3. three.js: ThreeShaderToy
<i>ShaderToy shaders work with minor changes.</i> The process of loading shaders in three.js is unfortunately a bit complicated, but the shader code itself should work the same as in p5.js&mdash;both are WebGL.
 
### 4. Unity: UnityShaderToy   
<i>ShaderToy shaders require major changes.</i> Unity has the friendliest overall approach to shader writing, and also the best documentation...but using ShaderToy shaders requires an extra setup step. While it's possible to modify ShaderToy's GLSL shaders for direct use in Unity, they'll only work in OpenGL mode--which isn't practical for most Windows desktop apps, including for VR. Instead, use the included converter script to convert the shader language from GLSL to CGFX, which Unity can use with both OpenGL and DirectX. (More complex shaders will require additional manual correction.)

### 5. openFrameworks: ofShaderToy
<i>ShaderToy shaders work with minor changes.</i> Shaders in oF work a bit differently than you may be used to from other approaches, but modifying the shader code shouldn't be any more difficult.

### 6. Raspberry Pi (oF): RPiShaderToy
TK


