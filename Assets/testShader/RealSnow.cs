using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RealSnow : MonoBehaviour
{
	const int SNOW_NUM = 4000;
	private Vector3[] vertices_;
	private int[] triangles_;
	private Color[] colors_;
	private Vector2[] uvs_;

	// 雪の範囲
	private float range_;

	// 雪範囲の逆数
	private float rangeR_;

	// 雪の移動量
	private Vector3 move_ = Vector3.zero;

	void Start()
	{
		range_ = 16.0f;
		rangeR_ = 1.0f / range_;
		vertices_ = new Vector3[SNOW_NUM*4];
		for (var i = 0; i < SNOW_NUM; i++) {
			float x = Random.Range (-range_, range_);
			float y = Random.Range (-range_, range_);
			float z = Random.Range (-range_, range_);
			var point = new Vector3(x, y, z);
			vertices_ [i*4+0] = point;
			vertices_ [i*4+1] = point;
			vertices_ [i*4+2] = point;
			vertices_ [i*4+3] = point;
		}

		triangles_ = new int[SNOW_NUM * 6];
		for (var i = 0; i < SNOW_NUM; i++) {
			triangles_[i*6] = i*4;
			triangles_[i * 6 + 1] = i * 4 + 1;
			triangles_[i * 6 + 2] = i * 4 + 2;
			triangles_[i * 6 + 3] = i * 4 + 2;
			triangles_[i * 6 + 4] = i * 4 + 1;
			triangles_[i * 6 + 5] = i * 4 + 3;
		}

		uvs_ = new Vector2[SNOW_NUM * 4];
		for (var i = 0; i < SNOW_NUM; i++) {
			uvs_ [i * 4 + 0] = new Vector2 (0f, 0f);
			uvs_ [i * 4 + 1] = new Vector2 (1f, 0f);
			uvs_ [i * 4 + 2] = new Vector2 (0f, 1f);
			uvs_ [i * 4 + 3] = new Vector2 (1f, 1f);
		}

		Mesh mesh = new Mesh();
		mesh.name = "SnowMesh";
		mesh.vertices = vertices_;
		mesh.triangles = triangles_;
		mesh.colors = colors_;
		mesh.uv = uvs_;
		mesh.bounds = new Bounds(Vector3.zero, Vector3.one * 100000);
		var meshFilter = GetComponent<MeshFilter>();
		meshFilter.sharedMesh = mesh;
	}

	void LateUpdate()
	{
		var target_position = Camera.main.transform.TransformPoint(Vector3.forward * range_);
		var meshRenderer = GetComponent<Renderer>();
		meshRenderer.material.SetFloat("_Range", range_);
		meshRenderer.material.SetFloat("_RangeR", rangeR_);
		meshRenderer.material.SetFloat("_Size", 0.1f);
		meshRenderer.material.SetVector("_MoveTotal", move_);
		meshRenderer.material.SetVector("_CamUp", Camera.main.transform.up);
		meshRenderer.material.SetVector("_TargePosition", target_position);

		float x = (Mathf.PerlinNoise(0f, Time.time * 0.1f) - 0.5f) * 10.0f; 
		float y = -2.0f;
		float z = (Mathf.PerlinNoise(0f, Time.time * 0.1f) - 0.5f) * 10.0f; 

		move_ += new Vector3(x, y, z) * Time.deltaTime;
		move_.x = Mathf.Repeat(move_.x, range_ * 2.0f);
		move_.y = Mathf.Repeat(move_.y, range_ * 2.0f);
		move_.z = Mathf.Repeat(move_.z, range_ * 2.0f);
	}

}
