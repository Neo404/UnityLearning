Shader "Custom/circleDrawShader" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_sinWaveFloat ("Sin Wave Float", float) = 3.0
		_sinBorder ("Sin Border", float) = 0.98
		_moveSpeed ("Move Speed", float) = 100
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200

		CGPROGRAM
		#pragma surface surf Standard
		#pragma target 3.0

		sampler2D _MainTex;

		struct Input {
			float3 worldPos;
		};

		fixed4 _Color;
		float _sinWaveFloat;
		float _sinBorder;
		float _moveSpeed;

		void surf (Input IN, inout SurfaceOutputStandard o) {
			float worldDistance = distance(fixed3(0,0,0), IN.worldPos);
			float val = abs(sin(worldDistance * _sinWaveFloat -_Time*_moveSpeed));
			if (val > _sinBorder) {
				o.Albedo = fixed4(1,1,1,1);
			} else {
				o.Albedo = fixed4(110/255.0, 87/255.0, 139/255.0, 1);
			}
		}
		ENDCG
	}
	FallBack "Diffuse"
}
