// based on https://alastaira.wordpress.com/2015/08/07/unity-shadertoys-a-k-a-converting-glsl-shaders-to-cghlsl/

using System;
using UnityEngine;

[ExecuteInEditMode]
public class ShaderToyImageEffect : MonoBehaviour { //UnityStandardAssets.ImageEffects.ImageEffectBase {

    public Material material;
    public enum RenderMode { FULL_RES, LOW_RES };
    public RenderMode renderMode = RenderMode.FULL_RES;
    public int horizontalResolution = 320;
    public int verticalResolution = 240;

    // Called by camera to apply image effect
    void OnRenderImage(RenderTexture source, RenderTexture destination) {
        if (renderMode == RenderMode.FULL_RES) {
            // To draw the shader at full resolution, use: 
            Graphics.Blit (source, destination, material);
        } else {
            // To draw the shader at scaled down resolution, use:
            RenderTexture scaled = RenderTexture.GetTemporary(horizontalResolution, verticalResolution);
            Graphics.Blit(source, scaled, material);
            Graphics.Blit(scaled, destination);
            RenderTexture.ReleaseTemporary(scaled);
        }
    }

}
