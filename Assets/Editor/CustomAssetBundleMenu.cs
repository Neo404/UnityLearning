using System.Collections;
using System.Collections.Generic;
using System.IO;
using UnityEditor;
using UnityEngine;

public class CustomAssetBundleMenu
{
    [MenuItem("CustomTools/Build Asset Bundle")]
    public static void Build()
    {
        var assetBundleDirectory = "./Build01";

        // ディレクトリがない場合作成
        if (!Directory.Exists(assetBundleDirectory)) {
            Directory.CreateDirectory(assetBundleDirectory);
        }

        BuildPipeline.BuildAssetBundles(assetBundleDirectory, BuildAssetBundleOptions.None,
        BuildTarget.StandaloneWindows);

        EditorUtility.DisplayDialog("end of Build", "ビルド終了", "OK");
    }
}
