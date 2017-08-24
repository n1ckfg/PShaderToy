// Original Source: http://www.iquilezles.org/apps/shadertoy/

Shader "ShaderToy/SquareTunnel" {
	
	Properties {
		_Color("Color", Color) = (1,.5,.5,1)
		_MainTex("Texture", 2D) = "white" {}
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
			sampler2D _MainTex;

			fixed4 frag (v2f i) : SV_Target {
				float r = pow(pow(i.uv.x*i.uv.x, 16.0) + pow(i.uv.y*i.uv.y, 16.0), 1.0 / 32.0);
				i.uv.x = .5*_Time.y + 0.5 / r;
				i.uv.y = 1.0*atan2(i.uv.y, i.uv.x) / 3.1416;

				float3 col = tex2D(_MainTex, i.uv).xyz;

				return float4(col*r*r*r, 1.0) * _Color;
			}

			ENDCG
		}
	}

}
