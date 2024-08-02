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
"vec3 i;\n"
"#define BPS 0.50420168\n"
"float f()"
"{"
"return v-.05;"
"}"
"float s(float v)"
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
"float t(float v)"
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
"float n(vec3 v,vec3 m)"
"{"
"v=abs(v)-m;"
"return length(max(v,0.))+min(max(v.x,max(v.y,v.z)),0.);"
"}"
"vec3 s(vec3 v,vec3 m)"
"{"
"return v-m*round(v/m);"
"}"
"float t(float v,float m)"
"{"
"return max(v,-m);"
"}"
"void m(inout vec3 v,inout float m)"
"{"
"float f=dot(v,v);"
"if(f<1.7)"
"{"
"float s=1.7/f;"
"v*=s;"
"m*=s;"
"}"
"}"
"void r(inout vec3 v,inout float m)"
"{"
"v=clamp(v,-1.,1.)*2.-v;"
"}"
"float m(vec3 f)"
"{"
"if(t(138.)>.9&&t(160.)<.9)"
"return 1e4;"
"i=f;"
"float s=-.85-sin(v*.002)*.45;"
"vec3 c=f;"
"float y=20.;"
"for(int v=0;v<13;v++)"
"r(f,y),m(f,y),f=s*f+c,y=y*abs(s)+1.;"
"s=length(f);"
"return s/abs(y);"
"}"
"float r(vec3 m)"
"{"
"if(t(124.)>.9&&t(160.)<.9||t(232.)>.9&&t(240.)<.9||t(256.)>.9&&t(272.)<.9||t(336.)>.9&&t(376.)<.9)"
"{"
"vec3 s=vec3(6,0,0);"
"float y=.628+sin(v*.6)*.2,i=1e4;"
"for(float r=0.;r<3.;r+=1.)"
"for(float x=0.;x<10.;x+=1.)"
"{"
"vec3 c=m-vec3(0,-2.+r*2.,0)-f(x*y+v*.5)*s;"
"i=min(i,n(f(-y)*c,vec3(.4)));"
"}"
"return i;"
"}"
"return 1e4;"
"}"
"float d(vec3 y)"
"{"
"float i=m((y+vec3(30,cos(v*.0025)*30.,1))*(sin(v*.025)+1.5)*.025),c=6.+t(140.)*2.,x=2.5+t(128.)*3.-t(140.)*2.;"
"i=min(t(i,f(y,vec2(c,x))),length(s(y+vec3(sin(v)*1.6,1.5,cos(v)*1.6),vec3(6,5,6)))-.7);"
"vec3 l=vec3(6,6,2)*(1.5-n()*.5);"
"x=t(i,n(s(vec3(0,0,5.*sin(v*.1))+y*n(v*.1),vec3(10)),l));"
"return min(x,r(y));"
"}"
"vec3 x(vec3 v)"
"{"
"vec2 m=vec2(1,-1)*.5773;"
"return normalize(m.xyy*d(v+m.xyy*5e-4)+m.yyx*d(v+m.yyx*5e-4)+m.yxy*d(v+m.yxy*5e-4)+m.xxx*d(v+m.xxx*5e-4));"
"}"
"float c(float v)"
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
"float s=c(float(i))*2.5;"
"f+=(s-max(d(v+m*s),0.))/2.5*2.5;"
"}"
"return clamp(1.-f/9.,.05,1.);"
"}"
"vec3 e(vec3 v)"
"{"
"float m=sin(v.x*7.)*.4+.6;"
"return vec3(1,m,m*.75);"
"}"
"int c()"
"{"
"return 4+int(t(128.))*3;"
"}"
"int d()"
"{"
"return 1+int(t(124.))*4-int(t(160.))*3;"
"}"
"float e()"
"{"
"return 6.-t(124.)*2.5;"
"}"
"vec3 h(float v)"
"{"
"return vec3(mod(v,7.)/14.,mod(v,5.)/5.,.5+mod(v,3.)/6.);"
"}"
"vec2 p(vec3 m)"
"{"
"float f=s(1.)*.05+.05+t(120.)*.05,i=1e4,y=i,x=float(-c())*e()/2.+6.,l=0.;"
"for(int s=0;s<c();++s)"
"{"
"float r=float(s);"
"for(int s=0;s<d();++s)"
"{"
"float c=float(s+1);"
"i=min(i,n(m+vec3(c*e()+3.*sin(v*.2*c)+cos(m.z*.5),x+e()*r+sin(m.z*.5),x+r*e()*2.*sin(v*.25*c)),vec3(f,f,4.+t(120.)*6.)));"
"if(i<y)"
"l=float(d())*c+r,y=i;"
"}"
"}"
"return vec2(i,l);"
"}"
"vec3 c(vec3 v,vec3 m,float s)"
"{"
"float f=0.;"
"vec3 i;"
"float y=0.;"
"for(int s=0;s<64;s++)"
"{"
"i=m+f*v;"
"vec2 c=p(i);"
"float x=c.x;"
"if(x<1e-4)"
"{"
"y=c.y;"
"break;"
"}"
"else if(f>15.)"
"break;"
"f+=x;"
"}"
"return f<15.&&f<s?"
"h(y):"
"vec3(0);"
"}"
"void main()"
"{"
"vec2 c=vec2(1920,1080);"
"c=(-c.xy+2.*gl_FragCoord.xy)/c.y;"
"float y=.05*v+sin(v*.1)*c.y*sin(v*.05)*2.;"
"y*=s()*2.-1.;"
"vec3 l=vec3(8.*cos(y),.6,8.*sin(y)),n=normalize(vec3(0,sin(v*.5),0)-l),z=normalize(cross(n,vec3(0,.6,.5)));"
"n=normalize(c.x*z+c.y*normalize(cross(z,n))+1.5*n);"
"y=0.;"
"float t=1e5,b=0.;"
"for(int v=0;v<128;v++)"
"{"
"l=y+f*r;"
"float m=d(l);"
"if(m<.00015)"
"{"
"vec2 m=p(l);"
"t=m.x;"
"z=m.y;"
"break;"
"}"
"else if(f>35.)"
"break;"
"f+=m;"
"}"
"vec3 B=vec3(0);"
"if(f<35.)"
"{"
"vec3 v=x(l);"
"float f=clamp(dot(v,vec3(.7,1.2,.4)),0.,1.2);"
"f*=f;"
"f*=f;"
"f*=s(16.);"
"float m=.5+.5*dot(v,vec3(0,.8,-.6));"
"m*=s(16.);"
"B=vec3(.2,.3,.5)*m+e(i)*vec3(.9,.8,.6)*f;"
"B*=c(l,v);"
"if(t<2.)"
"{"
"float v=(2.-t)/2.;"
"B+=v*v*v*h(z)*(s(1.)*.5+.5);"
"}"
"B/=max(1.,l.z*.5);"
"}"
"B=sqrt(B);"
"B=B*.5+.5*B*B*(3.-2.*B);"
"y=c(r,y,f);"
"gl_FragColor=vec4(B,f)+vec4(y,0);"
"}";