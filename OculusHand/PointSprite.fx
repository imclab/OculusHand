
//////////////////////////////////////////////////////////////

//�p�����[�^
const matrix Transform;		//�ϊ��s��
const float PointSize;		//�_�̕`��̑傫��

//////////////////////////////////////////////////////////////

struct VertexShaderInput
{
    float3 Position : POSITION0;	//�_�̍��W
	float3 Color : NORMAL0;			//�_�̐F
};

struct VertexShaderOutput
{
    float4 Position : POSITION0;
	float4 Color : COLOR0;
	float Size : PSIZE0;
};

//////////////////////////////////////////////////////////////

VertexShaderOutput VertexShaderFunction(const VertexShaderInput input)
{
	VertexShaderOutput output;
	output.Position.xyz = input.Position;
	output.Position.w = 1;
	output.Size = PointSize;

	output.Color.rgb = input.Color.rgb;
	output.Color.a = 1;

	output.Position = mul(output.Position, Transform);
	output.Position.z = 0;	//�Ȃ񂩂��ꂪ�Ȃ��ƃ_���H

    return output;
}

float4 PixelShaderFunction(const VertexShaderOutput input) : COLOR0
{
	return input.Color;
}

//////////////////////////////////////////////////////////////

technique PointSprite
{
	pass p0
	{
		VertexShader = compile vs_2_0 VertexShaderFunction();
		PixelShader = compile ps_2_0 PixelShaderFunction();
	}
}