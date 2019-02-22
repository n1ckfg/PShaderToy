### 1. Processing: PShaderToy
<i>ShaderToy shaders require minor changes.</i> If you have no prior experience with any of these approaches, Processing can probably get you up and running with shaders the fastest.

### 2. Unity: UnityShaderToy   
<i>ShaderToy shaders require major changes.</i> Unity has the friendliest overall approach to shader writing, and also the best documentation, but using ShaderToy shaders requires an extra setup step. (While it's possible to modify ShaderToy's GLSL shaders for direct use in Unity, they'll only work in OpenGL mode--which isn't practical for most Windows desktop apps, including for VR. Instead, use the included converter script to convert the shader language from GLSL to CGFX, which Unity can use with both OpenGL and DirectX. More complex shaders will require additional manual correction.)

### 3. p5.js: p5jsShaderToy
<i>ShaderToy shaders don't usually require changes.</i> Setting up and running a new JavaScript project can take a bit of practice, but once you get past that, p5.js's approach to working with shaders is the simplest of all. If you've written JS before, start here.

### 4. three.js: ThreeShaderToy
<i>ShaderToy shaders don't usually require changes.</i> The process of loading shaders in three.js is unfortunately a bit complicated, but ShaderToy shader code itself should work fine as is.
 
### 5. openFrameworks: ofShaderToy
<i>ShaderToy shaders require minor changes.</i> Using shaders in oF works a bit differently than you may be used to from other approaches, but modifying the shader code shouldn't be any more difficult than with Processing.

### 6. Raspberry Pi (oF): RPiShaderToy
TK


