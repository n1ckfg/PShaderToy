precision mediump float;

varying vec2 vTexCoord;

uniform sampler2D tex0;

void main() {
    vec2 uv = vec2(vTexCoord.x, 1.0 - vTexCoord.y);
    vec4 col = texture2D(tex0, uv);

    gl_FragColor = vec4(1.0-col.xyz, col.w);
}