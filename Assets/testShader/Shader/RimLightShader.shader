Shader "Custom/RimLightShader" {
	Properties {
		_TexColor ("Tex Color", Color) = (0.05,0.1,0,1)
		_RimColor ("Rim Color", Color) = (0.5, 0.7, 0.5, 1)
		_Float ("Rim Power", float) = 2.5
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200

		CGPROGRAM

		#pragma surface surf Standard fullforwardshadows
		#pragma target 3.0

		struct Input {
			float2 uv_MainTex;
			float3 wordlNormal;
			float3 viewDir;
		};

		fixed4 _TexColor;
		fixed4 _RimColor;
		fixed _Float;

		void surf (Input IN, inout SurfaceOutputStandard o) {
			o.Albedo = _TexColor;

			// 法線ベクトルとオブジェクトのベクトルの内積を求め、0~1の値にクランプした値を引く
			float rim = 1 - saturate(dot(IN.viewDir, o.Normal));

			// 光の減衰をシャープにするために、rimを2.5乗した値をrimColorに掛ける
			o.Emission = _RimColor * pow(rim, _Float);
		}
		ENDCG
	}
	FallBack "Diffuse"
}
