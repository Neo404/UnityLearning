using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TestAbLoad : MonoBehaviour
{
    IEnumerator Start()
    {
        var ab = AssetBundle.LoadFromFile("Build01/abprefab");
        if (ab == null)
        {
            yield break;
        }

        var abMaterial = AssetBundle.LoadFromFile("Build01/abmaterial");

        var prefab = ab.LoadAsset<GameObject>("redCube");
        var material = abMaterial.LoadAsset<Material>("red");
        GameObject go = Instantiate(prefab);
        go.GetComponent<Renderer>().material = material;

        yield return new WaitUntil(() => Input.GetMouseButton(0));

        ab.Unload(true);
        abMaterial.Unload(true);
        Debug.Log("Unload完了");
    }
}
