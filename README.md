### 1. Processing: PShaderToy
<i>ShaderToy shaders work with minor changes.</i> Start here if you have no prior experience with shader writing, but are already comfortable in a C-like language. Processing's shader markup is probably most similar to ShaderToy's overall.

### 2. p5.js: p5jsShaderToy
<i>ShaderToy shaders work with minor changes.</i> The p5.js Web Editor is extremely friendly, so start here if you've written any JavaScript before. Otherwise, be aware that setting up a new JS project from scratch can take a bit of practice if you're not used to it. 

### 3. three.js: ThreeShaderToy
<i>ShaderToy shaders work with minor changes.</i> The process of loading shaders in three.js is unfortunately a little complicated, but it's boilerplate code that doesn't usually change. The shader code itself should work the same as in p5.js&mdash;both are WebGL.
 
### 4. openFrameworks (oF 0.10.1): ofShaderToy
<i>ShaderToy shaders require intermediate changes.</i> Shaders in oF work a little differently than in the above approaches, and modifying them may require slightly more understanding of what's going on in the code.

### 5. openFrameworks for Raspberry Pi (oF 0.10.1): RPiShaderToy
<i>ShaderToy shaders require intermediate changes.</i> Same as for desktop oF, except you need to take the extra step of checking that the shaders work with OpenGL ES (mobile). Start with the desktop version if you've never written shaders for oF before.

### 6. Unity: UnityShaderToy   
<i>ShaderToy shaders require major changes.</i> Unity is the odd one out among these approaches, because it uses a different shader language--CGFX instead of GLSL. While it's possible to modify ShaderToy's GLSL shaders for direct use in Unity, they'll only work in OpenGL mode; that's impractical for most Windows desktop apps, including for VR. So instead, use the included converter script to convert the shader language from GLSL to CGFX, which Unity can use with both OpenGL and DirectX. (More complex shaders will require additional manual correction.) The good news is, once you make it through this process, Unity offers the friendliest overall approach to shader writing, and also the best documentation.


