// Original Source: http://www.iquilezles.org/apps/shadertoy/

Shader "ShaderToy/Mandel" {
	
	Properties {
		//
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
			
			fixed4 frag (v2f i) : SV_Target {
				float zoo = .62 + .38*sin(.1*_Time.y);
				float coa = cos(0.1*(1.0 - zoo)*_Time.y);
				float sia = sin(0.1*(1.0 - zoo)*_Time.y);
				zoo = pow(zoo, 8.0);
				float2 xy = float2(i.uv.x*coa - i.uv.y*sia, i.uv.x*sia + i.uv.y*coa);
				float2 cc = float2(-.745, .186) + xy*zoo;

				float2 z = float2(0.0, 0.0);
				float2 z2 = z*z;
				float m2;
				float co = 0.0;
				for (int i = 0; i<256; i++) {
					z = cc + float2(z.x*z.x - z.y*z.y, 2.0*z.x*z.y);
					m2 = dot(z, z);
					if (m2>1024.0) break;
					co += 1.0;
				}
				co = co + 1.0 - log2(.5*log2(m2));

				co = sqrt(co / 256.0);
				return float4(.5 + .5*cos(6.2831*co + 0.0),
					.5 + .5*cos(6.2831*co + 0.4),
					.5 + .5*cos(6.2831*co + 0.7),
					1.0);
			}

			ENDCG
		}
	}

}
