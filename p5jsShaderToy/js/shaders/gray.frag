precision mediump float;

varying vec2 vTexCoord;

uniform sampler2D tex0;

float luma(vec3 color) {
    return dot(color, vec3(0.299, 0.587, 0.114));
}

void main() {
    vec2 uv = vec2(vTexCoord.x, 1.0 - vTexCoord.y);
    vec4 col = texture2D(tex0, uv);

    float gray = luma(col.rgb);
    gl_FragColor = vec4(vec3(gray), col.w);
}