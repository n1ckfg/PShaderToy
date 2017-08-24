// Original Source: http://www.iquilezles.org/apps/shadertoy/
Shader "ShaderToy/Pulse" {
	
	Properties {
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
			
			sampler2D _MainTex;

			fixed4 frag(v2f i) : SV_Target{
				float2 halfres = _ScreenParams.xy / 2.0;
				float2 cPos = (i.screenCoord.xy * _ScreenParams.xy);

				cPos.x -= 0.5*halfres.x*sin(_Time.y / 2.0) + 0.3*halfres.x*cos(_Time.y) + halfres.x;
				cPos.y -= 0.4*halfres.y*sin(_Time.y / 5.0) + 0.3*halfres.y*cos(_Time.y) + halfres.y;
				float cLength = length(cPos);

				float2 uv = (i.screenCoord.xy * _ScreenParams.xy) / _ScreenParams.xy + (cPos / cLength)*sin(cLength / 30.0 - _Time.y*10.0) / 25.0;
				float3 col = tex2D(_MainTex, uv).xyz*50.0 / cLength;

				return float4(col, 1.0);
			}

			ENDCG
		}
	}

}
