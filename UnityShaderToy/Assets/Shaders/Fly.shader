// Original Source: http://www.iquilezles.org/apps/shadertoy/

Shader "ShaderToy/Fly" {
	
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
			};

			v2f vert (appdata v) {
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				return o;
			}
			
			sampler2D _MainTex;

			fixed4 frag (v2f i) : SV_Target{
				float an = _Time.y*.25;

				float x = i.uv.x*cos(an) - i.uv.y*sin(an);
				float y = i.uv.x*sin(an) + i.uv.y*cos(an);

				//uvpos.x = .25*x/abs(y);
				//uvpos.y = .20*_Time.y + .25/abs(y);

				return float4(tex2D(_MainTex, i.uv).xyz * y*y, 1.0);
			}

			ENDCG
		}
	}

}
