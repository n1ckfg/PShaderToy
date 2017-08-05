uniform vec2 iResolution;
uniform float iGlobalTime;
uniform vec4 iMouse;

uniform sampler2D texture;

void main() {
	vec2 uv = gl_FragCoord.xy / iResolution.xy;
	vec4 col = texture2D(texture, uv);
	vec2 mouse = iMouse.xy / iResolution.xy;

    gl_FragColor = vec4(mouse, 0.5 + (0.5 * sin(iGlobalTime / 1000.0)), 1.0) + col;
}