// Original Source: http://www.iquilezles.org/apps/shadertoy/

Shader "ShaderToy/ReliefTunnel" {
	
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

			fixed4 frag (v2f i) : SV_Target {
				float r = sqrt(dot(i.uv, i.uv));
				float a = atan2(i.uv.y, i.uv.x) + 0.5*sin(0.5*r - 0.5*_Time.y);

				float s = 0.5 + 0.5*cos(7.0*a);
				s = smoothstep(0.0, 1.0, s);
				s = smoothstep(0.0, 1.0, s);
				s = smoothstep(0.0, 1.0, s);
				s = smoothstep(0.0, 1.0, s);

				i.uv.x = _Time.y + 1.0 / (r + .2*s);
				i.uv.y = 3.0*a / 3.1416;

				float w = (0.5 + 0.5*s)*r*r;

				float3 col = tex2D(_MainTex, i.uv).xyz;

				float ao = 0.5 + 0.5*cos(7.0*a);
				ao = smoothstep(0.0, 0.4, ao) - smoothstep(0.4, 0.7, ao);
				ao = 1.0 - 0.5*ao*r;

				return float4(col*w*ao, 1.0) * _Color;
			}

			ENDCG
		}
	}

}
