// Original Source: http://www.iquilezles.org/apps/shadertoy/

Shader "ShaderToy/Kaleidoscope" {
	
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
				float4 screenCoord : TEXCOORD1;
			};

			v2f vert (appdata v) {
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				o.screenCoord.xy = ComputeScreenPos(o.vertex);
				return o;
			}

			float4 _Color;
			sampler2D _MainTex;

			fixed4 frag (v2f i) : SV_Target{
				float2 p = -1.0 + 2.0 * (i.screenCoord.xy * _ScreenParams.xy) / _ScreenParams.xy;
				float2 uv;

				float a = atan2(p.y, p.x);
				float r = sqrt(dot(p, p));

				uv.x = 7.0*a / 3.1416;
				uv.y = -_Time.y + sin(7.0*r + _Time.y) + .7*cos(_Time.y + 7.0*a);

				float w = .5 + .5*(sin(_Time.y + 7.0*r) + .7*cos(_Time.y + 7.0*a));

				float3 col = tex2D(_MainTex, uv*.5).xyz;

				return float4(col*w, 1.0) * _Color;
			}

			ENDCG
		}
	}

}
