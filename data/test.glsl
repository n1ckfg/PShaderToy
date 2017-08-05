uniform vec3 iResolution; 
uniform float iGlobalTime;
uniform vec4 iMouse;

uniform sampler2D texture;

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
	vec2 uv = fragCoord.xy / iResolution.xy;
	vec4 col = texture2D(texture, uv);
	vec2 mouse = iMouse.xy / iResolution.xy;

    fragColor = vec4(mouse, 0.5 + (0.5 * sin(iGlobalTime)), 1.0) + col;
}

void main() {
	mainImage(gl_FragColor, gl_FragCoord.xy);
}