Shader "Custom/RimLightShader" {
	Properties {
		_Color ("Color", Color) = (0.05,0.1,0,1)
		_Color2 ("Rim Color", Color) = (0.5, 0.7, 0.5, 1)
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

		fixed4 _Color;
		fixed4 _Color2;
		fixed _Float;

		void surf (Input IN, inout SurfaceOutputStandard o) {
			fixed4 baseColor = fixed4(0.05, 0.1, 0, 1);
			fixed4 rimColor = fixed4(0.5, 0.7, 0.5, 1);

			o.Albedo = _Color;

			// 法線ベクトルとオブジェクトのベクトルの内積を求め、0~1の値にクランプした値を引く
			float rim = 1 - saturate(dot(IN.viewDir, o.Normal));
			o.Emission = _Color2 * pow(rim, _Float);
		}
		ENDCG
	}
	FallBack "Diffuse"
}
