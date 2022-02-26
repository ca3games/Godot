shader_type canvas_item;

uniform vec4 zero = vec4(0, 0, 0, 0);
uniform vec4 shirt_color : hint_color;
uniform vec4 shirt_replace : hint_color;

uniform vec4 hat_color : hint_color;
uniform vec4 hat_replace : hint_color;

uniform vec4 pants_color : hint_color;
uniform vec4 pants_replace : hint_color;

uniform vec4 skin_color : hint_color;
uniform vec4 skin_replace : hint_color;

uniform vec4 mask_color : hint_color;
uniform vec4 mask_replace : hint_color;


uniform sampler2D dissolve_texture;
uniform vec4 burn_color : hint_color = vec4(1);
uniform float burn_size : hint_range(0, 2);
uniform float dissolve_amount : hint_range(0, 1);
uniform float emission_amount;


void fragment()
{
	vec4 col = texture(TEXTURE, UV);
	if (lessThan(vec4(0.001), abs(col - shirt_color)) == bvec4(false)) 
	{
		col = shirt_replace;
	}
	if (lessThan(vec4(0.001), abs(col - hat_color)) == bvec4(false)) 
	{
		col = hat_replace;
	}
	if (lessThan(vec4(0.001), abs(col - pants_color)) == bvec4(false)) 
	{
		col = pants_replace;
	}
	if (lessThan(vec4(0.001), abs(col - skin_color)) == bvec4(false)) 
	{
		col = skin_replace;
	}
	if (lessThan(vec4(0.001), abs(col - mask_color)) == bvec4(false)) 
	{
		col = mask_replace;
	}
	
	vec4 out_color = col;

    float sample = texture(dissolve_texture, UV).r;
    float emission_value = 1.0 - smoothstep(dissolve_amount, dissolve_amount + burn_size, sample);
    vec3 emission = burn_color.rgb * emission_value * emission_amount;
    
    vec4 tmp = vec4(max(out_color.rgb, emission), smoothstep(dissolve_amount - burn_size, dissolve_amount, sample) * out_color.a);
	
	COLOR = tmp;
}
