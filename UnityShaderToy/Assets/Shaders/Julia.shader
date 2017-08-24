// Original Source: http://www.iquilezles.org/apps/shadertoy/

Shader "ShaderToy/Julia" {
	
	Properties {
		_Color("Color", Color) = (1,.5,.5,1) 
	}

	SubShader {

		Pass {
			CGPROGRAM
			
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			struct appdata {
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f {
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};

			v2f vert (appdata v) {
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				return o;
			}
			
			float4 _Color;

			fixed4 frag(v2f i) : SV_Target{
				float2 cc = float2(cos(.25*_Time.y), sin(.25*_Time.y*1.423));

				float dmin = 1000.0;
				float2 z = i.uv*float2(1.33, 1.0);
				for (int i = 0; i < 64; i++) {
					z = cc + float2(z.x*z.x - z.y*z.y, 2.0*z.x*z.y);
					float m2 = dot(z, z);
					if (m2 > 100.0) break;
					dmin = min(dmin, m2);
				}

				float color = 1.0 - sqrt(sqrt(dmin))*0.7;
				return float4(color, color, color, 1.0) * _Color;
			}

			ENDCG
		}
	}

}
