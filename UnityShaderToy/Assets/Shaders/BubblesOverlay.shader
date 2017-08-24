// See https://www.shadertoy.com/view/4dl3zn
// GLSL -> HLSL reference: https://msdn.microsoft.com/en-GB/library/windows/apps/dn166865.aspx

Shader "ShaderToy/BubblesOverlay" {

	Properties{
		_MainTex("Texture", 2D) = "white" {}
		_Brightness("Brightness", Float) = 0.5
		_Size("Size", Float) = 4.0
		_Color1("Color 1", Color) = (0.94,0.3,0.0,1)
		_Color2("Color 2", Color) = (0.1,0.4,0.8,1)
	}

	SubShader{

		Tags{ "RenderType" = "Transparent" "QUEUE" = "Transparent+100" }
		Lighting Off
		Cull Off
		ZTest Always
		ZWrite Off
		Blend SrcAlpha OneMinusSrcAlpha

		Pass {
			CGPROGRAM

			#pragma vertex vert
			#pragma fragment frag
			#pragma fragmentoption ARB_precision_hint_fastest

			#include "UnityCG.cginc"

			struct appdata {
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f {
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};

			v2f vert(appdata v) {
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				return o;
			}

			float _Brightness;
			float3 _Color1;
			float3 _Color2;
			float _Size;
			sampler2D _MainTex;

			fixed4 frag(v2f i) : SV_Target { 
				// Background
				fixed4 outColour = fixed4(0, 0, 0, 0);// 0.8 + 0.2*uv.y, 0.8 + 0.2*uv.y, 0.8 + 0.2*uv.y, 1);

				// Bubbles
				for (int j = 0; j < 40; j++) {
					// Bubble seeds
					float pha = sin(float(j)*546.13 + 1.0)*0.5 + 0.5;
					float siz = pow(sin(float(j)*651.74 + 5.0)*0.5 + 0.5, 4.0) * _Size;
					float pox = sin(float(j)*321.55 + 4.1);

					// Bubble size, position and color
					float rad = 0.1 + 0.5*siz;
					float2  pos = float2(pox, -1.0 - rad + (2.0 + 2.0*rad)*fmod(pha + 0.1*_Time.y*(0.2 + 0.8*siz),1.0));
					float dis = 0.1;// length(uv – pos);
					//float3 col = lerp(float3(0.94,0.3,0.0), float3(0.1,0.4,0.8), 0.5 + 0.5*sin(float(i)*1.2 + 1.9));
					float3 col = lerp(_Color1, _Color2, 0.5 + 0.5*sin(float(j)*1.2 + 1.9));

					// Add a black outline around each bubble
					col += 8.0*smoothstep(rad*0.95, rad, dis);

					// Render
					float f = length(i.uv - pos) / rad;
					f = sqrt(clamp(1.0 - f*f,0.0,1.0));

					outColour.rgb += col.zyx *(1.0 - smoothstep(rad*0.95, rad, dis)) * f;
					outColour += tex2D(_MainTex, i.uv);
				}

				// Vignetting    
				outColour *= sqrt(1.5 - 0.5*length(i.uv)) * _Brightness;

				return outColour;
			}

		ENDCG
		}
	}
}