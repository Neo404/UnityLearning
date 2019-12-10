Shader "Custom/UVScrollShader" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_scrollSpeedX ("scrollSpeed X", float) = 0.1
		_scrollSpeedY ("scrollSpeed Y", float) = 0.2
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200

		CGPROGRAM
		#pragma surface surf Standard fullforwardshadows
		#pragma target 3.0

		sampler2D _MainTex;

		struct Input {
			float2 uv_MainTex;
		};

		fixed4 _Color;
		fixed _scrollSpeedX;
		fixed _scrollSpeedY;

		void surf (Input IN, inout SurfaceOutputStandard o) {
			fixed2 uv = IN.uv_MainTex;
			uv.x += _scrollSpeedX * _Time;
			uv.y += _scrollSpeedY * _Time;
			o.Albedo = tex2D(_MainTex, uv);
		}
		ENDCG
	}
	FallBack "Diffuse"
}
