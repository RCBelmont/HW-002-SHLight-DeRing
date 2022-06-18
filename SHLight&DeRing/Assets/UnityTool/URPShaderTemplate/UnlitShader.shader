Shader "URPTemplet/UnlitShaderTemplet"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _MainColor("Color", Color) = (1,1,1,1)
    }
    SubShader
    {
        Tags
        {
            "RenderPipeline" = "UniversalPipeline"
            "Queue" = "Geometry"
            "RenderType"="Opaque"
            "UniversalMaterialType" = "Unlit"
        }


        Pass
        {
            Name "Universal Forward"
            Tags {}
            Cull Back
            Blend One Zero
            ZTest LEqual
            ZWrite On

            HLSLPROGRAM
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #pragma vertex vert
            #pragma fragment frag
            //a2v
            struct Attributes
            {
                float3 positionOS : POSITION;
                float3 normalOS : NORMAL;
                float4 tangentOS : TANGENT;
                float2 uv : TEXCOORD0;
            };

            //v2f
            struct Varings
            {
                float4 positionCS : SV_POSITION;
                float3 normalOS : NORMAL;
                float4 tangentOS : TANGENT;
                float2 uv : TEXCOORD;
            };

            struct FragOut
            {
                float4 Color:SV_Target;
            };

            CBUFFER_START(UnityPerMaterial)
            float4 _MainColor;
            CBUFFER_END
            TEXTURE2D(_MainTex);
            SAMPLER(sampler_MainTex);

            Varings vert(Attributes IN)  
            {
                Varings OUT;
                VertexPositionInputs positionInputs = GetVertexPositionInputs(IN.positionOS.xyz);
                OUT.positionCS = positionInputs.positionCS;
                return OUT;
            }

            FragOut frag(Varings IN)
            {
                FragOut OUT;
                OUT.Color = _MainColor;
                return OUT; 
            }
            ENDHLSL
        }
    }
}