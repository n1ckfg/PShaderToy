// Original Source: http://www.iquilezles.org/apps/shadertoy/

Shader "ShaderToy/Monjori" {
	
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
				float2 p = i.uv;
				float a = _Time.y*40.0;
				float d, e, f, g = 1.0 / 40.0, h, ii, r, q;
				e = 400.0*(p.x*0.5 + 0.5);
				f = 400.0*(p.y*0.5 + 0.5);
				ii = 200.0 + sin(e*g + a / 150.0)*20.0;
				d = 200.0 + cos(f*g / 2.0)*18.0 + cos(e*g)*7.0;
				r = sqrt(pow(ii - e, 2.0) + pow(d - f, 2.0));
				q = f / r;
				e = (r*cos(q)) - a / 2.0; f = (r*sin(q)) - a / 2.0;
				d = sin(e*g)*176.0 + sin(e*g)*164.0 + r;
				h = ((f + d) + a / 2.0)*g;
				ii = cos(h + r*p.x / 1.3)*(e + e + a) + cos(q*g*6.0)*(r + h / 3.0);
				h = sin(f*g)*144.0 - sin(e*g)*212.0*p.x;
				h = (h + (f - e)*q + sin(r - (a + h) / 7.0)*10.0 + ii / 4.0)*g;
				ii += cos(h*2.3*sin(a / 350.0 - q))*184.0*sin(q - (r*4.3 + a / 12.0)*g) + tan(r*g + h)*184.0*cos(r*g + h);
				ii = fmod(ii / 5.6, 256.0) / 64.0;
				if(ii<0.0) ii += 4.0;
				if(ii >= 2.0) ii = 4.0 - ii;
				d = r / 350.0;
				d += sin(d*d*8.0)*0.52;
				f = (sin(a*g) + 1.0) / 2.0;
				return float4(float3(f*ii / 1.6, ii / 2.0 + d / 13.0, ii)*d*p.x + float3(ii / 1.3 + d / 8.0, ii / 2.0 + d / 18.0, ii)*d*(1.0 - p.x), 1.0);
			}
			ENDCG
		}
	}

}
