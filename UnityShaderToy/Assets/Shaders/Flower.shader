// Original Source: http://www.iquilezles.org/apps/shadertoy/

Shader "ShaderToy/Flower" {
	
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
			
			fixed4 frag (v2f i) : SV_Target{
				float a = atan2(i.uv.y,i.uv.x);
				float r = length(i.uv)*.75;
				
				float w = cos(3.1415927*_Time.y-r*2.0);
				float h = 0.5+0.5*cos(12.0*a-w*7.0+r*8.0);
				float d = 0.25+0.75*pow(h,1.0*r)*(0.7+0.3*w);
				
				float col = ( d-r ) * sqrt(1.0-r/d)*r*2.5;
				col *= 1.25+0.25*cos((12.0*a-w*7.0+r*8.0)/2.0);
				col *= 1.0 - 0.35*(0.5+0.5*sin(r*30.0))*(0.5+0.5*cos(12.0*a-w*7.0+r*8.0));
				return float4(
					col,
					col-h*0.5+r*.2 + 0.35*h*(1.0-r),
					col-h*r + 0.1*h*(1.0-r),
					1.0);
			}

			ENDCG
		}
	}

}
