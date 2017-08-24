void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    float inverseSpeed = 60.;
    
	vec2 uv = fragCoord.xy / iResolution.y;
    
    vec3 topColor = vec3(0.2, 0.0, 0.4);
    vec3 bottomColor = vec3(1.0, 0.5, 0.0);
    vec3 gradient1 = mix(bottomColor, topColor, uv.y - iGlobalTime/inverseSpeed);
    
    vec2 sunCenter = vec2(0.9, iGlobalTime/inverseSpeed);
    float r = distance(uv, sunCenter);
    float sun = 1. - smoothstep(0.0, 0.1, r);
    
    vec3 gradient = mix (gradient1, vec3(1.25,1.35,1.4), clamp(mix((1.0 - uv.y), 1.0, iGlobalTime/inverseSpeed) * iGlobalTime/inverseSpeed, 0., 1.));
    
    float halo = 1. - smoothstep(0.0, 0.5, r) - iGlobalTime/inverseSpeed;
    float horizon = 1. - smoothstep(0.0, clamp(0.2 - iGlobalTime/(inverseSpeed*3.), 0.0, 0.2), uv.y);
    vec3 horizonColor = vec3(0.2, 0.6, 0.6);
    
	fragColor = vec4(gradient + (sun + halo * bottomColor) * (1. - horizon) + horizon * horizonColor, 1.0);
	//fragColor = vec4(gradient + (sun + halo * bottomColor), 1.0);
}
