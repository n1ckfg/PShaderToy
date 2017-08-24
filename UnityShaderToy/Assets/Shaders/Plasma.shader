// Original Source: http://www.iquilezles.org/apps/shadertoy/

Shader "ShaderToy/Plasma" {

	Properties {
		//
	}

	SubShader {

		Pass {
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			struct appdata{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
				float4 screenCoord : TEXCOORD1;
			};

			v2f vert (appdata v){
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				o.screenCoord.xy = ComputeScreenPos(o.vertex);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target{
			   float x = i.uv.x;
			   float y = i.uv.y;
			   float mov0 = x+y+cos(sin(_Time.y)*2.)*100.+sin(x/100.)*1000.;
			   float mov1 = y / _ScreenParams.y / 0.2 + _Time.y;
			   float mov2 = x / _ScreenParams.x / 0.2;
			   float c1 = abs(sin(mov1+_Time.y)/2.+mov2/2.-mov1-mov2+_Time.y);
			   float c2 = abs(sin(c1+sin(mov0/1000.+_Time.y)+sin(y/40.+_Time.y)+sin((x+y)/100.)*3.));
			   float c3 = abs(sin(c2+cos(mov1+mov2+c2)+cos(mov2)+sin(x/1000.)));
			   return float4( c1,c2,c3,1.0);
			}
				
			ENDCG
		}
	}

}

