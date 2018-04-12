#version 150

uniform sampler2DRect tex0;

in vec2 texCoordVarying;

out vec4 outputColor;
 
void main()
{
    outputColor = vec4(1,0,0,1);//texture(tex0, texCoordVarying);
}