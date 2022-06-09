Shader "Custom/dissolve"
{
       Properties
    { 
        _TexRust ("Rust (RGB)", 2D) = "white" {}
        _TexDissolve ("dissolve (RGB)", 2D) = "white" {}
        _TexMetal ("Metal (RGB)", 2D) = "white" {}
        _dissolveSlider ("Dissolve Slider name", Range (0, 1)) = 0
    }
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert addshadow 

        sampler2D _TexRust;
        sampler2D _TexDissolve;
        sampler2D _TexMetal;
        float _dissolveSlider;


        struct Input
        {
            float2 uv_TexRust;
            float2 uv_TexDissolve;
            float2 uv_TexMetal;
        };


        void surf (Input IN, inout SurfaceOutput o)
        {
            // textura do dissolve
            float3 dissolveResult = tex2D(_TexDissolve, IN.uv_TexDissolve);
         
            o.Albedo = tex2D(_TexRust, IN.uv_TexRust);

            //calculo do dissolve com o slider
            float dissolveLimit = dissolveResult + _dissolveSlider;

            // se o dissolve na tuxtura do metal vai mostrar
            if(dissolveLimit < 0.8){
                
                 o.Emission =  tex2D(_TexMetal, IN.uv_TexMetal);
            }
            //abaixo de 0 da discard a textura do metal
            clip(dissolveLimit);
        }
        ENDCG
    }

    FallBack "Diffuse"
}
