using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace Olympvs
{
    public class blip : MonoBehaviour
    {
        public Material mat;
        public float slider = 0f;
        
        void Update()
        {
            mat.SetFloat("_slider", slider);

            if (slider > 0)
                DecreaseSlider();
        }

        public void OnRenderImage(RenderTexture src, RenderTexture dest)
        {
            Graphics.Blit(src, dest, mat);     
        }

        public void DecreaseSlider()
        {
            slider -= 0.4f * Time.deltaTime;
            if (slider < 0)
                slider = 0;
        }

        public void IncreaseSlider()
        {
            slider += 0.4f;
            if (slider > 1)
                slider = 1;
        }
    }
}

