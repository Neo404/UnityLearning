using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class animationScript : MonoBehaviour
{
    private Transform Hip;
    private Transform LeftLeg;
    private Transform LeftKnee;
    private Transform RightLeg;
    private Transform RightKnee;

    void Start()
    {
        Hip = transform.Find("Armature").Find("Hips");
        LeftLeg = Hip.Find("Left leg");
        LeftKnee = LeftLeg.Find("Left knee");
        RightLeg = Hip.Find("Right leg");
        RightKnee = RightLeg.Find("Right knee");
    }

    void FixedUpdate()
    {
        Vector3 RotateAxis = new Vector3(1, 0, 0);

        float pendulum = (float)Math.Sin(Time.time * Math.PI);
        float minusValue = 60 * pendulum;
        LeftLeg.rotation = Quaternion.AngleAxis(-180.0f + minusValue - 20.0f, RotateAxis);
        RightLeg.rotation = Quaternion.AngleAxis(180.0f - minusValue - 20.0f, RotateAxis);

        LeftKnee.rotation = Quaternion.AngleAxis(-180.0f + minusValue + minusValue / 2, RotateAxis);
        RightKnee.rotation = Quaternion.AngleAxis(180.0f - minusValue - minusValue / 2, RotateAxis);
    }
}
