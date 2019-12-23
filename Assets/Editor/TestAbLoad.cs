using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TestAbLoad : MonoBehaviour
{
    void Start()
    {
        var ab = AssetBundle.LoadFromFile("Build01");
        if (ab == null)
        {
            Debug.Log("失敗です");
            return;
        }

        var prefab = ab.LoadAsset<GameObject>("redCube");
        Instantiate(prefab);

        //yield return new WaitUntil(() => Input.GetMouseButton(0));

        ab.Unload(true);
        Debug.Log("Unload完了");
    }
}
