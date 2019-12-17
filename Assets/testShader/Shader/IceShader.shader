Shader "Custom/IceShader" {

	// リムライト風のシェーダーサンプル実装
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_Float ("Alpha Rate", float) = 1.5
	}

	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200

		CGPROGRAM
		#pragma surface surf Standard alpha:fade
		#pragma target 3.0

		fixed _Float;

		// オブジェクトの法線ベクトルと視線ベクトル
		struct Input {
			float3 wordlNormal;
			float2 viewDir;
		};

		half _Glossiness;
		half _Metallic;
		fixed4 _Color;

		void surf (Input IN, inout SurfaceOutputStandard o) {
			o.Albedo = fixed4(1, 1, 1, 1);

			// オブジェクトの法線とカメラの向きの内席を求める
			// 垂直の場合0 平行の場合1 or -1
			float normalDot = dot(IN.viewDir, IN.wordlNormal);

			// 垂直の場合1 平行の場合0
			float alpha = 1 - (abs(normalDot));
			o.Alpha = alpha * _Float;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
