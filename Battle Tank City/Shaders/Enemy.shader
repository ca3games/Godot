shader_type spatial;
render_mode unshaded;

uniform sampler2D albedoRed;
uniform sampler2D albedo1HP;
uniform sampler2D albedo2HP;
uniform sampler2D albedo3HP;
uniform sampler2D albedo4HP;
uniform float Metallic : hint_range(0, 1);
uniform float Roughness : hint_range(0, 1);
uniform sampler2D normal;

uniform bool Red;
uniform int HP_texture;

void fragment()
{
	if (Red)
	{
		ALBEDO = texture(albedoRed, UV).rgb;
		NORMALMAP = texture(normal, UV).rgb;
		METALLIC = Metallic;
		ROUGHNESS = Roughness;
	}
	else
	{
		if (HP_texture == 0) { ALBEDO = texture(albedo1HP, UV).rgb; }
		if (HP_texture == 1) { ALBEDO = texture(albedo2HP, UV).rgb; }
		if (HP_texture == 2) { ALBEDO = texture(albedo3HP, UV).rgb; }
		if (HP_texture == 3) { ALBEDO = texture(albedo4HP, UV).rgb; }
		NORMALMAP = texture(normal, UV).rgb;
		METALLIC = Metallic;
		ROUGHNESS = Roughness;
	}
}