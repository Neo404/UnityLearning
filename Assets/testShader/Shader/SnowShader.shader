Shader "Custom/SnowShader" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Glossiness ("Smoothness", Range(0,1)) = 0.5
		_Metallic ("Metallic", Range(0,1)) = 0.0
		_Snow("Snow", Range(0,2)) = 0.0
	}

	//TODO デモ用の雪シェーダー 上から吹いてくる雪シェーダーは後日改めて作成
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200

		CGPROGRAM
		#pragma surface surf Standard fullforwardshadows
		#pragma target 3.0

		sampler2D _MainTex;

		struct Input {
			float2 uv_MainTex;
			float3 worldNormal;
		};

		half _Glossiness;
		half _Metallic;
		fixed4 _Color;
		half _Snow;


		void surf (Input IN, inout SurfaceOutputStandard o) {
			// y軸方向に対する法線ベクトルの内積を計算 上向きに近いほど値が大きくなる
			float worldDot = dot(IN.worldNormal, fixed3(0, 1, 0));

			fixed4 color = tex2D (_MainTex, IN.uv_MainTex) * _Color;
			fixed4 white = fixed4(1,1,1,1);

			// テクスチャの色と白色を線形補間する
			color = lerp(color, white, worldDot*_Snow);

			o.Albedo = c.rgb;
			o.Metallic = _Metallic;
			o.Smoothness = _Glossiness;
			o.Alpha = 1;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
