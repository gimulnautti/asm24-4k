#pragma once

static const char* imageShader = \
"#version 330\n"
"layout(location=0) out vec4 v;"
"uniform sampler2D m;"
"vec4 x(vec2 v)"
"{"
"float n=1.;"
"vec4 f=vec4(0);"
"for(float x=-5.;x<=5.;x+=1.)"
"for(float i=-5.;i<=5.;i+=1.)"
"{"
"vec4 d=texture2D(m,v+vec2(x,i)*(vec2(7)/vec2(1920,1080)));"
"if(max(d.x,max(d.y,d.z))>.8)"
"{"
"float m=length(vec2(x,i))+1.;"
"vec4 v=max(d*128./pow(m,2.),vec4(0));"
"if(max(v.x,max(v.y,v.z))>.9)"
"f+=v,n+=1.;"
"}"
"}"
"return f/n;"
"}"
"void main()"
"{"
"vec2 d=gl_FragCoord.xy/vec2(1920,1080);"
"v=texture(m,d)+.05*x(d);"
"}";