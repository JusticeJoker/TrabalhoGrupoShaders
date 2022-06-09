Shader "Unlit/asdf"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _BaseSpeed ("Texture", 2D) = "white" {}
        _Transparency("Transparency", Range (0.0, 0.5)) = 0.25
    }
    SubShader
    {
        Tags { "Queue"="Transparent" "RenderType"="Transparent"}
        
        Zwrite On
        Blend SrcAlpha OneMinusSrcAlpha

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            #pragma multi_compile_fog

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            float _Transparency;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                float2 movement = float2 (0, _Time.x); // calculo do movimento no tempo no eixo do x
                fixed4 col = tex2D(_MainTex, i.uv + movement); //aplicaçao da textura com o movimento               
                col.a = _Transparency; // slider da transparencia com alpha
                return col;
            }
            ENDCG
        }
    }
}
