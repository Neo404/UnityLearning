using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class animationScript : MonoBehaviour
{
    private Transform Hip;
    private Transform LeftLeg;
    private Transform RightLeg;

    void Start()
    {
        Hip = transform.Find("Armature").Find("Hips");
        LeftLeg = Hip.Find("Left leg");
        RightLeg = Hip.Find("Right leg");
    }

    void FixedUpdate()
    {
        Vector3 RotateAxis = new Vector3(1, 0, 0);

        float pendulum = (float)Math.Sin(Time.time * Math.PI);
        float minusValue = 60 * pendulum;
        LeftLeg.rotation = Quaternion.AngleAxis(-180.0f + minusValue, RotateAxis);
        RightLeg.rotation = Quaternion.AngleAxis(180.0f - minusValue, RotateAxis);
    }
}
