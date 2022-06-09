Shader "Custom/holograma"
{
  Properties{
        _borderColor("Border Color", Color) = (1,1,1,1)
        _border("Color strength", Range(1, 10)) = 1
        _intensity("Color Intensity", Range(1,10)) = 1
        _insideColor("Inside Color", Color) = (1,1,1,1)
    }
    SubShader{

        CGPROGRAM
        #pragma surface surf Lambert alpha

        struct Input {
        float3 viewDir;
        };

        float3 _borderColor;
        float _border;
        float _intensity;
        float3 _insideColor;

        void surf(Input IN, inout SurfaceOutput o)
        {
            float dotp = 1 - dot(normalize(IN.viewDir), o.Normal);

            if (dotp <= 0.5f)
            {
                o.Emission = _insideColor;
            }
            else
            {
                o.Emission = pow(_borderColor.rgb * dotp, _border) * _intensity;
            }

            o.Alpha = (o.Emission.r + o.Emission.g + o.Emission.b) / 3;

        }

        ENDCG
    }
        FallBack "Diffuse"
}
