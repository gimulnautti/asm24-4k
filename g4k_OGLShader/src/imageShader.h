#pragma once

static const char* imageShader = \
"#version 430\n"
"varying vec2 m;"
"uniform sampler2D v;"
"vec4 x(vec2 m)"
"{"
"float p=1.;"
"vec4 y=vec4(0);"
"for(float f=-5.;f<=5.;f+=1.)"
"for(float i=-5.;i<=5.;i+=1.)"
"{"
"vec4 r=texture2D(v,m+vec2(f,i)*(vec2(7)/vec2(1280,720)));"
"if(max(r.x,max(r.y,r.z))>.8)"
"{"
"float v=length(vec2(f,i))+1.;"
"vec4 m=max(r*128./pow(v,2.),vec4(0));"
"if(max(m.x,max(m.y,m.z))>.9)"
"y+=m,p+=1.;"
"}"
"}"
"return y/p;"
"}"
"void main()"
"{"
"vec2 r=m.xy/vec2(2).xy+vec2(.5);"
"gl_FragColor=texture2D(v,r)+.05*x(r);"
"}";