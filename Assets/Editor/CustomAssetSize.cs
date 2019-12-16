using System.Collections;
using System.Collections.Generic;
using System.IO;
using UnityEditor;
using UnityEngine;

public static class CustomAssetSize
{

	[InitializeOnLoadMethod]
	private static void ShowSize()
	{
		//EditorApplication.projectWindowItemOnGUI += OnGUI;
	}
	
	private static void OnGUI(string guid, Rect selectionRect)
	{
		var dataPath = Application.dataPath;
		var index = dataPath.LastIndexOf("Assets");
		var dir = dataPath.Remove(index, "Assets".Length);
		var path = dir + AssetDatabase.GUIDToAssetPath(guid);

		if (!File.Exists(path))
		{
			//TODO 何故かファイルが存在しない扱いになってしまう 要確認
			Debug.Log("表示するファイルはありません");
			return;
		}

		var file = new FileInfo(path);
		var fileSize = file.Length;

		var showText = fileSize.ToString();
		var showPos = selectionRect;

		var label = EditorStyles.label;
		var content = new GUIContent(showText);
		var width = label.CalcSize(content).x;

		showPos.x = showPos.xMax - width;
		showPos.width = width;
		showPos.yMin++;

		GUI.Label(showPos, showText);
	}
}
