//--------------------------------------------------------------------------//
// iq / rgba  .  tiny codes  .  2008/2021                                   //
//--------------------------------------------------------------------------//

static const char* fragmentShader = \
"#version 430\n"
"uniform float v;"
"mat3 n(float v)"
"{"
"float m=sin(v);"
"v=cos(v);"
"return mat3(vec3(1,0,0),vec3(0,v,m),vec3(0,-m,v));"
"}"
"mat3 f(float v)"
"{"
"float m=sin(v);"
"v=cos(v);"
"return mat3(vec3(v,0,m),vec3(0,1,0),vec3(-m,0,v));"
"}"
"mat3 s(float v)"
"{"
"float m=sin(v);"
"v=cos(v);"
"return mat3(vec3(v,m,0),vec3(-m,v,0),vec3(0,0,1));"
"}"
"vec3 i;\n"
"#define BPS 0.50420168\n"
"float f()"
"{"
"return v+.05;"
"}"
"float t(float v)"
"{"
"v*=BPS;"
"return smoothstep(0.,1.,1.-mod(f(),v)/v);"
"}"
"float n()"
"{"
"float v=32.*BPS;"
"return mod(f(),v)/v<.5?"
"0.:"
"1.;"
"}"
"float m(float v)"
"{"
"v*=BPS;"
"return f()<v?"
"0.:"
"1.;"
"}"
"float f(vec3 v,vec2 m)"
"{"
"return length(vec2(length(v.xz)-m.x,v.y))-m.y;"
"}"
"float m(vec3 v,vec3 m)"
"{"
"v=abs(v)-m;"
"return length(max(v,0.))+min(max(v.x,max(v.y,v.z)),0.);"
"}"
"vec3 n(vec3 v,vec3 m)"
"{"
"return v-m*round(v/m);"
"}"
"float s(float v,float m)"
"{"
"return max(v,-m);"
"}"
"void t(inout vec3 v,inout float m)"
"{"
"float f=dot(v,v);"
"if(f<1.7)"
"{"
"float c=1.7/f;"
"v*=c;"
"m*=c;"
"}"
"}"
"void r(inout vec3 v,inout float m)"
"{"
"v=clamp(v,-1.,1.)*2.-v;"
"}"
"float r(vec3 f)"
"{"
"if(m(138.)>.9&&m(160.)<.9||m(368.)>.9)"
"return 1e4;"
"i=f;"
"float c=-.85-sin(v*.002)*.45;"
"vec3 s=f;"
"float y=20.;"
"for(int v=0;v<13;v++)"
"r(f,y),t(f,y),f=c*f+s,y=y*abs(c)+1.;"
"c=length(f);"
"return c/abs(y);"
"}"
"float d(vec3 c)"
"{"
"if(m(124.)>.9&&m(160.)<.9||m(232.)>.9&&m(240.)<.9||m(256.)>.9&&m(272.)<.9||m(288.)>.9&&m(304.)<.9||m(336.)>.9&&m(380.)<.9)"
"{"
"vec3 y=vec3(6,0,0);"
"float i=6.28/15.+sin(v*.35)*.1,r=1e4;"
"for(float x=0.;x<3.;x+=1.)"
"for(float l=0.;l<15.;l+=1.)"
"{"
"vec3 B=c-vec3(0,-2.+x*2.,0),k=B-f(l*i+v*.65)*y;"
"B=f(-i)*k;"
"if(m(336.)>.9)"
"B=n(v*.43)*s(v*.52)*B;"
"r=min(r,m(B,vec3(.4)));"
"}"
"return r;"
"}"
"return 1e4;"
"}"
"float c(vec3 i)"
"{"
"float c=r((i+vec3(30,cos(v*.0025)*30.,1))*(sin(v*.025)+1.5)*.025),y=6.+m(140.)*2.,B=2.5+m(128.)*3.-m(140.)*2.;"
"c=min(s(c,f(i,vec2(y,B))),length(n(i+vec3(sin(v)*1.6,1.5,cos(v)*1.6),vec3(6,5,6)))-.7);"
"vec3 l=vec3(6,6,2)*(1.5-n()*.5);"
"B=s(c,m(n(vec3(0,0,5.*sin(v*.1))+i*n(v*.1),vec3(10)),l));"
"return min(B,d(i));"
"}"
"vec3 x(vec3 v)"
"{"
"vec2 m=vec2(1,-1)*.5773;"
"return normalize(m.xyy*c(v+m.xyy*5e-4)+m.yyx*c(v+m.yyx*5e-4)+m.yxy*c(v+m.yxy*5e-4)+m.xxx*c(v+m.xxx*5e-4));"
"}"
"float e(float v)"
"{"
"vec3 m=fract(vec3(v)*.1031);"
"m+=dot(m,m.yzx+19.19);"
"return fract((m.x+m.y)*m.z);"
"}"
"float c(vec3 v,vec3 m)"
"{"
"float f=0.;"
"for(int i=0;i<9;i++)"
"{"
"float y=e(float(i))*2.5;"
"f+=(y-max(c(v+m*y),0.))/2.5*2.5;"
"}"
"return clamp(1.-f/9.,.05,1.);"
"}"
"vec3 h(vec3 v)"
"{"
"float m=sin(v.x*7.)*.4+.6;"
"return vec3(1,m,m*.75);"
"}"
"int c()"
"{"
"return 4+int(m(128.))*3;"
"}"
"int d()"
"{"
"return 1+int(m(124.))*4-int(m(160.))*3;"
"}"
"float e()"
"{"
"return 6.-m(124.)*2.5;"
"}"
"vec3 p(float v)"
"{"
"return vec3(mod(v,7.)/14.,mod(v,5.)/5.,.5+mod(v,3.)/6.);"
"}"
"vec2 B(vec3 i)"
"{"
"float f=t(1.)*.05+.05+m(120.)*.05,r=1e4,y=r,B=float(-c())*e()/2.+6.,l=0.;"
"for(int s=0;s<c();++s)"
"{"
"float x=float(s);"
"for(int c=0;c<d();++c)"
"{"
"float s=float(c+1);"
"r=min(r,m(i+vec3(s*e()+3.*sin(v*.2*s)+cos(i.z*.5),B+e()*x+sin(i.z*.5),B+x*e()*2.*sin(v*.25*s)),vec3(f,f,4.+m(120.)*6.)));"
"if(r<y)"
"l=float(d())*s+x,y=r;"
"}"
"}"
"return vec2(r,l);"
"}"
"vec3 B(vec3 v,vec3 m,float i)"
"{"
"float f=0.;"
"vec3 c;"
"float y=0.;"
"for(int i=0;i<64;i++)"
"{"
"c=m+f*v;"
"vec2 s=B(c);"
"float r=s.x;"
"if(r<1e-4)"
"{"
"y=s.y;"
"break;"
"}"
"else if(f>15.)"
"break;"
"f+=r;"
"}"
"return f<15.&&f<i?"
"p(y):"
"vec3(0);"
"}"
"void main()"
"{"
"vec2 m=vec2(1920,1080);"
"m=(-m.xy+2.*gl_FragCoord.xy)/m.y;"
"float f=.05*v+sin(v*.1)*m.y*sin(v*.05)*2.;"
"f*=n()*2.-1.;"
"vec3 r=vec3(8.*cos(f),.6,8.*sin(f)),y=normalize(vec3(0,sin(v*.5),0)-r),s=normalize(cross(y,vec3(0,.6,.5)));"
"y=normalize(m.x*s+m.y*normalize(cross(s,y))+1.5*y);"
"f=0.;"
"float l=1e5,z=0.;"
"for(int v=0;v<128;v++)"
"{"
"s=r+f*y;"
"float m=c(s);"
"if(m<.00015)"
"{"
"vec2 m=B(s);"
"l=m.x;"
"z=m.y;"
"break;"
"}"
"else if(f>35.)"
"break;"
"f+=m;"
"}"
"vec3 d=vec3(0);"
"if(f<35.)"
"{"
"vec3 v=x(s);"
"float f=clamp(dot(v,vec3(.7,1.2,.4)),0.,1.2);"
"f*=f;"
"f*=f;"
"f*=t(16.);"
"float m=.5+.5*dot(v,vec3(0,.8,-.6));"
"m*=t(16.);"
"d=vec3(.2,.3,.5)*m+h(i)*vec3(.9,.8,.6)*f;"
"d*=c(s,v);"
"if(l<2.)"
"{"
"float v=(2.-l)/2.;"
"d+=v*v*v*p(z)*(t(1.)*.5+.5);"
"}"
"d/=max(1.,s.z*.5);"
"}"
"d=sqrt(d);"
"d=d*.5+.5*d*d*(3.-2.*d);"
"r=B(y,r,f);"
"gl_FragColor=vec4(d,f)+vec4(r,0);"
"}";