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
	
	COLOR = col;
}