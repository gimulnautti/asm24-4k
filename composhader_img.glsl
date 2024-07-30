#version 430
varying vec2 fragCoord;
uniform sampler2D gm_BaseTexture;

vec2 px()
{
    return vec2(7.) / vec2(1280,720);
}

vec4 GetBloom ( in vec2 uv )
{
	float numSamples = 1.;
    vec4 color = vec4(0.);

	for (float x = -5.; x <= 5.; x += 1.)
	{
		for (float y = -5.; y <= 5.; y += 1.)
		{
			vec4 addColor = texture2D(gm_BaseTexture, uv + (vec2(x, y) * px()));
			if (max(addColor.r, max(addColor.g, addColor.b)) > .8)
			{
				float dist = length(vec2(x,y))+1.;

				vec4 glowColor = max((addColor * 128.) / pow(dist, 2.), vec4(0.));

                if (max(glowColor.r, max(glowColor.g, glowColor.b)) > .9)
				{
					color += glowColor;
					numSamples += 1.;
				}
			}
		}
	}
    
	return color / numSamples;
}


void main( void )
{
    vec2 iResolution = vec2(2.,2.);
    vec2 uv=fragCoord.xy/iResolution.xy + vec2(.5,.5);
    vec4 box = texture2D(gm_BaseTexture, uv);
    gl_FragColor = box + .05 * GetBloom(uv);
}