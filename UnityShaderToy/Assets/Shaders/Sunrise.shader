// Original Source: http://www.iquilezles.org/apps/shadertoy/

Shader "ShaderToy/Sunrise"{
	
	Properties{ 
		_Horizon("Horizon", Float) = 1.0
		_Sun("Sun", Float) = 0.1
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
			
			float _Horizon;
			float _Sun;

			fixed4 frag (v2f i) : SV_Target {
				float inverseSpeed = 60.0;
    
				float2 uv = i.screenCoord.xy * _ScreenParams.xy / _ScreenParams.y;
    
				float3 topColor = float3(0.2, 0.0, 0.4);
				float3 bottomColor = float3(1.0, 0.5, 0.0);
				float3 gradient1 = lerp(bottomColor, topColor, uv.y - _Time.y/inverseSpeed);
    
				float2 sunCenter = float2(0.9, _Time.y/inverseSpeed);
				float r = distance(uv, sunCenter);
				float sun = 1.0 - smoothstep(0.0, _Sun, r);
    
				float3 gradient = lerp (gradient1, float3(1.25,1.35,1.4), clamp(lerp((1.0 - uv.y), 1.0, _Time.y/inverseSpeed) * _Time.y/inverseSpeed, 0., 1.));
    
				float halo = 1.0 - smoothstep(0.0, 0.5, r) - _Time.y/inverseSpeed;
				float horizon = _Horizon - smoothstep(0.0, clamp(0.2 - _Time.y/(inverseSpeed*3.), 0.0, 0.2), uv.y);
				float3 horizonColor = float3(0.2, 0.6, 0.6);
    
				return float4(gradient + (sun + halo * bottomColor) * (1. - horizon) + horizon * horizonColor, 1.0);
				//return float4(gradient + (sun + halo * bottomColor), 1.0);
			}
				
			ENDCG
		}
	}

}
