// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/realSnowShader" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Base (RGB)", 2D) = "white" {}
	}

	// リアル寄り雪の描画 ハンズオン
	SubShader {
		Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" }
		LOD 200
		Zwrite Off
		Cull Off
		// アルファブレンドをミックスする
		Blend SrcAlpha OneMinusSrcAlpha

		Pass {
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0

			#include "UnityCG.cginc"

			uniform sampler2D _MainTex;

			struct appdata_custom {
				float4 vertex : POSITION;
				float2 texcoord : TEXCOORD0;
			};

			struct v2f {
				float4 pos:SV_POSITION;
				float2 uv:TEXCOORD0;
			};

			fixed4 _Color;
			float4x4 _PrevInvMatrix;
			float3 _TargetPosition;
			float _Range;
			float _RangeR;
			float _Size;
			float3 _MoveTotal;
			float3 _CamUp;


			v2f vert (appdata_custom v) {
				float3 target = _TargetPosition;
				float3 trip;
				float3 mv = v.vertex.xyz;
				mv += _MoveTotal;
				trip = floor(((target - mv) * _RangeR + 1) * 0.5);
				trip *= (_RangeR * 2);
				mv += trip;

				float3 diff = _CamUp * _Size;
				float3 finalposition;
				float3 tv0 = mv;

				{
					float3 eyeVector = ObjSpaceViewDir(float4(tv0, 0));
					float3 sideVector = normalize(cross(eyeVector, diff));
					tv0 += (v.texcoord.x - 0.5f) * sideVector * _Size;
					tv0 += (v.texcoord.y - 0.5f) * diff;
					finalposition = tv0;
				}
				v2f o;
				o.pos = UnityObjectToClipPos(float4(finalposition, 1));
				o.uv = MultiplyUV(UNITY_MATRIX_TEXTURE0, v.texcoord);
				return o;
			}

			fixed4 frag(v2f i) : SV_Target
			{
				return tex2D(_MainTex, i.uv);
			}
			ENDCG
		}
		
	}
	FallBack "Diffuse"
}
