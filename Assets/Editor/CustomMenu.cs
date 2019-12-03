using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;

public class CustomMenu : MonoBehaviour {

	// Unityエディタ拡張作成テスト
	// shift + A で専用のショートカット
	[MenuItem("CustomTools/ConsoleTest #a")]
	public static void MenuConsole () {
		Debug.Log("動作確認用 ログ");
	}

	// コンポーネントの歯車にメニューを追加します
	[MenuItem("CONTEXT/Rigidbody/ShowLog")]
	private static void ShowLog(MenuCommand menucommand) {
		// 実行したRigidbodyを取得
		Rigidbody rigidbody = menucommand.context as Rigidbody;

		Debug.Log(rigidbody.gameObject.name);
	}
	
}
