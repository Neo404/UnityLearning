﻿Shader "Unlit/TestShader"
{
	// プロパティ宣言
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_Color ("Main Color", Color) = (1,0.5,1,1)
	}

	// サブシェーダー宣言
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100

		Pass
		{
			Tags { "LightMode" = "ForwardBase" }
			CGPROGRAM
			// プリプロセッサ
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_fog
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
				float4 normal : NORMAL;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
				float4 diffuse : COLOR0;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);

				float4 lightDir = dot(v.normal, ObjSpaceLightDir(v.vertex));
				o.diffuse = max(0, lightDir);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				fixed4 col = i.diffuse * tex2D(_MainTex, i.uv);
				return col;
			}
			ENDCG
		}
	}
}
