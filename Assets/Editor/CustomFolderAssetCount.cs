using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using UnityEditor;
using UnityEngine;

public static class CustomFolderAssetCount
{

	[InitializeOnLoadMethod]
	private static void ShowCount()
	{
		EditorApplication.projectWindowItemOnGUI += OnGUI;
	}

	private static void OnGUI(string guid, Rect selectionRect)
	{
		var dataPath = Application.dataPath;
		var index = dataPath.LastIndexOf("Assets");
		var dir = dataPath.Remove(index, "Assets".Length);
		var path = dir + AssetDatabase.GUIDToAssetPath(guid);

		var fileCount = Directory.GetFiles(path)
				.Where( c => !c.EndsWith(".meta") )
				.Count();

		var dirCount = Directory.GetDirectories(path).Length;

		var folderCount = fileCount + dirCount;

		var showText = folderCount.ToString();
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
