; Listing generated by Microsoft (R) Optimizing Compiler Version 19.40.33812.0 

	TITLE	C:\Users\Tonik\source\repos\asm24-4k\g4k_OGLShader\bin\Release\main_win_rel.obj
	.686P
	.XMM
	include listing.inc
	.model	flat

INCLUDELIB LIBCMT
INCLUDELIB OLDNAMES

PUBLIC	??_C@_0ONB@IFODBBKO@?$CDversion?5330?6layout?$CIlocation?$DN0?$CJ@ ; `string'
PUBLIC	??_C@_0BLM@BIHFLBJO@?$CDversion?5330?6layout?$CIlocation?$DN0?$CJ@ ; `string'
PUBLIC	__fltused
_BSS	SEGMENT
__fltused DD	01H DUP (?)
_BSS	ENDS
CONST	SEGMENT
?pfd@@3UtagPIXELFORMATDESCRIPTOR@@B DW 028H		; pfd
	DW	01H
	DD	025H
	DB	00H
	DB	020H
	DB	00H
	DB	00H
	DB	00H
	DB	00H
	DB	00H
	DB	00H
	DB	00H
	DB	00H
	DB	00H
	DB	00H
	DB	00H
	DB	00H
	DB	00H
	DB	020H
	DB	00H
	DB	00H
	DB	00H
	DB	00H
	DD	00H
	DD	00H
	DD	00H
?wavHeader@@3QBHB DD 046464952H				; wavHeader
	DD	0776924H
	DD	045564157H
	DD	020746d66H
	DD	010H
	DD	020001H
	DD	0ac44H
	DD	02b110H
	DD	0100004H
	DD	061746164H
	DD	0eed200H
CONST	ENDS
;	COMDAT ??_C@_0BLM@BIHFLBJO@?$CDversion?5330?6layout?$CIlocation?$DN0?$CJ@
CONST	SEGMENT
??_C@_0BLM@BIHFLBJO@?$CDversion?5330?6layout?$CIlocation?$DN0?$CJ@ DB '#v'
	DB	'ersion 330', 0aH, 'layout(location=0) out vec4 v;uniform samp'
	DB	'ler2D m;vec4 x(vec2 v){float n=1.;vec4 f=vec4(0);for(float x='
	DB	'-5.;x<=5.;x+=1.)for(float i=-5.;i<=5.;i+=1.){vec4 d=texture2D'
	DB	'(m,v+vec2(x,i)*(vec2(7)/vec2(1920,1080)));if(max(d.x,max(d.y,'
	DB	'd.z))>.8){float m=length(vec2(x,i))+1.;vec4 v=max(d*128./pow('
	DB	'm,2.),vec4(0));if(max(v.x,max(v.y,v.z))>.9)f+=v,n+=1.;}}retur'
	DB	'n f/n;}void main(){vec2 d=gl_FragCoord.xy/vec2(1920,1080);v=t'
	DB	'exture(m,d)+.05*x(d);}', 00H		; `string'
CONST	ENDS
;	COMDAT ??_C@_0ONB@IFODBBKO@?$CDversion?5330?6layout?$CIlocation?$DN0?$CJ@
CONST	SEGMENT
??_C@_0ONB@IFODBBKO@?$CDversion?5330?6layout?$CIlocation?$DN0?$CJ@ DB '#v'
	DB	'ersion 330', 0aH, 'layout(location=0) out vec4 f;uniform floa'
	DB	't v;mat3 n(float v){float m=sin(v);v=cos(v);return mat3(vec3('
	DB	'1,0,0),vec3(0,v,m),vec3(0,-m,v));}mat3 s(float v){float m=sin'
	DB	'(v);v=cos(v);return mat3(vec3(v,0,m),vec3(0,1,0),vec3(-m,0,v)'
	DB	');}mat3 t(float v){float m=sin(v);v=cos(v);return mat3(vec3(v'
	DB	',m,0),vec3(-m,v,0),vec3(0,0,1));}vec3 i;', 0aH, '#define BPS '
	DB	'0.50420168', 0aH, 'float n(){return v-.05;}float m(float v){v'
	DB	'*=BPS;return smoothstep(0.,1.,1.-mod(n(),v)/v);}float m(){flo'
	DB	'at v=32.*BPS;return mod(n(),v)/v<.5?0.:1.;}float r(float v){v'
	DB	'*=BPS;return n()<v?0.:1.;}float m(vec3 v,vec2 m){return lengt'
	DB	'h(vec2(length(v.xz)-m.x,v.y))-m.y;}float n(vec3 v,vec3 m){v=a'
	DB	'bs(v)-m;return length(max(v,0.))+min(max(v.x,max(v.y,v.z)),0.'
	DB	');}vec3 r(vec3 v,vec3 m){return v-m*round(v/m);}float s(float'
	DB	' v,float m){return max(v,-m);}void t(inout vec3 v,inout float'
	DB	' m){float f=dot(v,v);if(f<1.7){float c=1.7/f;v*=c;m*=c;}}void'
	DB	' d(inout vec3 v,inout float m){v=clamp(v,-1.,1.)*2.-v;}float '
	DB	'd(vec3 m){if(r(138.)>.9&&r(160.)<.9||r(368.)>.9)return 1e4;i='
	DB	'm;float f=-.85-sin(v*.002)*.45;vec3 c=m;float s=20.;for(int v'
	DB	'=0;v<13;v++)d(m,s),t(m,s),m=f*m+c,s=s*abs(f)+1.;f=length(m);r'
	DB	'eturn f/abs(s);}float x(vec3 m){if(r(124.)>.9&&r(160.)<.9||r('
	DB	'232.)>.9&&r(240.)<.9||r(256.)>.9&&r(272.)<.9||r(288.)>.9&&r(3'
	DB	'04.)<.9||r(336.)>.9&&r(380.)<.9){vec3 f=vec3(6,0,0);float c=6'
	DB	'.28/15.+sin(v*.35)*.1,i=1e4;for(float x=0.;x<3.;x+=1.)for(flo'
	DB	'at y=0.;y<15.;y+=1.){vec3 l=m-vec3(0,-2.+x*2.,0),k=l-s(y*c+v*'
	DB	'.65)*f;l=s(-c)*k;if(r(336.)>.9)l=n(v*.43)*t(v*.52)*l;i=min(i,'
	DB	'n(l,vec3(.4)));}return i;}return 1e4;}float c(vec3 f){float i'
	DB	'=d((f+vec3(30,cos(v*.0025)*30.,1))*(sin(v*.025)+1.5)*.025),c='
	DB	'6.+r(140.)*2.,l=2.5+r(128.)*3.-r(140.)*2.;i=min(s(i,m(f,vec2('
	DB	'c,l))),length(r(f+vec3(sin(v)*1.6,1.5,cos(v)*1.6),vec3(6,5,6)'
	DB	'))-.7);vec3 y=vec3(6,6,2)*(1.5-m()*.5);l=s(i,n(r(vec3(0,0,5.*'
	DB	'sin(v*.1))+f*n(v*.1),vec3(10)),y));return min(l,x(f));}vec3 e'
	DB	'(vec3 v){vec2 m=vec2(1,-1)*.5773;return normalize(m.xyy*c(v+m'
	DB	'.xyy*5e-4)+m.yyx*c(v+m.yyx*5e-4)+m.yxy*c(v+m.yxy*5e-4)+m.xxx*'
	DB	'c(v+m.xxx*5e-4));}float h(float v){vec3 m=fract(vec3(v)*.1031'
	DB	');m+=dot(m,m.yzx+19.19);return fract((m.x+m.y)*m.z);}float c('
	DB	'vec3 v,vec3 m){float f=0.;for(int i=0;i<9;i++){float l=h(floa'
	DB	't(i))*2.5;f+=(l-max(c(v+m*l),0.))/2.5*2.5;}return clamp(1.-f/'
	DB	'9.,.05,1.);}vec3 p(vec3 v){float m=sin(v.x*7.)*.4+.6;return v'
	DB	'ec3(1,m,m*.75);}int c(){return 4+int(r(128.))*3;}int d(){retu'
	DB	'rn 1+int(r(124.))*4-int(r(160.))*3;}float e(){return 6.-r(124'
	DB	'.)*2.5;}vec3 B(float v){return vec3(mod(v,7.)/14.,mod(v,5.)/5'
	DB	'.,.5+mod(v,3.)/6.);}vec2 l(vec3 f){float i=m(1.)*.05+.05+r(12'
	DB	'0.)*.05,l=1e4,s=l,x=float(-c())*e()/2.+6.,y=0.;for(int m=0;m<'
	DB	'c();++m){float B=float(m);for(int m=0;m<d();++m){float c=floa'
	DB	't(m+1);l=min(l,n(f+vec3(c*e()+3.*sin(v*.2*c)+cos(f.z*.5),x+e('
	DB	')*B+sin(f.z*.5),x+B*e()*2.*sin(v*.25*c)),vec3(i,i,4.+r(120.)*'
	DB	'6.)));if(l<s)y=float(d())*c+B,s=l;}}return vec2(l,y);}vec3 B('
	DB	'vec3 v,vec3 m,float f){float i=0.;vec3 c;float r=0.;for(int f'
	DB	'=0;f<64;f++){c=m+i*v;vec2 s=l(c);float y=s.x;if(y<1e-4){r=s.y'
	DB	';break;}else if(i>15.)break;i+=y;}return i<15.&&i<f?B(r):vec3'
	DB	'(0);}void main(){vec2 r=vec2(1920,1080);r=(-r.xy+2.*gl_FragCo'
	DB	'ord.xy)/r.y;float y=.05*v+sin(v*.1)*r.y*sin(v*.05)*2.;y*=m()*'
	DB	'2.-1.;vec3 s=vec3(8.*cos(y),.6,8.*sin(y)),x=normalize(vec3(0,'
	DB	'sin(v*.5),0)-s),d=normalize(cross(x,vec3(0,.6,.5)));x=normali'
	DB	'ze(r.x*d+r.y*normalize(cross(d,x))+1.5*x);y=0.;float n=1e5,z='
	DB	'0.;for(int v=0;v<128;v++){d=s+y*x;float m=c(d);if(m<.00015){v'
	DB	'ec2 m=l(d);n=m.x;z=m.y;break;}else if(y>35.)break;y+=m;}vec3 '
	DB	'a=vec3(0);if(y<35.){vec3 v=e(d);float f=clamp(dot(v,vec3(.7,1'
	DB	'.2,.4)),0.,1.2);f*=f;f*=f;f*=m(16.);float y=.5+.5*dot(v,vec3('
	DB	'0,.8,-.6));y*=m(16.);a=vec3(.2,.3,.5)*y+p(i)*vec3(.9,.8,.6)*f'
	DB	';a*=c(d,v);if(n<2.){float v=(2.-n)/2.;a+=v*v*v*B(z)*(m(1.)*.5'
	DB	'+.5);}a/=max(1.,d.z*.5);}a=sqrt(a);a=a*.5+.5*a*a*(3.-2.*a);s='
	DB	'B(x,s,y);f=vec4(a,y)+vec4(s,0);}', 00H	; `string'
CONST	ENDS
PUBLIC	?entrypoint@@YGXXZ				; entrypoint
PUBLIC	??_C@_06GGHJAEBN@static@			; `string'
PUBLIC	??_C@_0BH@BOJGDFJN@glCreateShaderProgramv@	; `string'
PUBLIC	??_C@_0BC@FAPEBGID@glGenFramebuffers@		; `string'
PUBLIC	??_C@_0BC@CJMIBNO@glBindFramebuffer@		; `string'
PUBLIC	??_C@_0BD@MIGEDNGJ@glGenRenderbuffers@		; `string'
PUBLIC	??_C@_0BD@EPOPJGFA@glBindRenderbuffer@		; `string'
PUBLIC	??_C@_0BG@EOIILGMJ@glRenderbufferStorage@	; `string'
PUBLIC	??_C@_0BK@OJDINAOA@glFramebufferRenderbuffer@	; `string'
PUBLIC	??_C@_0BF@ENLMLILA@glFramebufferTexture@	; `string'
PUBLIC	??_C@_0O@COHJKDBH@glDrawBuffers@		; `string'
PUBLIC	??_C@_0N@ICBDHBI@glUseProgram@			; `string'
PUBLIC	??_C@_0M@MLICAPOF@glUniform1f@			; `string'
PUBLIC	__real@3a83126f
PUBLIC	__real@433f0000
PUBLIC	__real@4f800000
EXTRN	__imp__Sleep@4:PROC
EXTRN	__imp__ExitProcess@4:PROC
EXTRN	__imp__ChoosePixelFormat@8:PROC
EXTRN	__imp__SetPixelFormat@12:PROC
EXTRN	__imp__wglCreateContext@4:PROC
EXTRN	__imp__wglGetProcAddress@4:PROC
EXTRN	__imp__wglMakeCurrent@8:PROC
EXTRN	__imp__wglSwapLayerBuffers@8:PROC
EXTRN	__imp__PeekMessageA@20:PROC
EXTRN	__imp__CreateWindowExA@48:PROC
EXTRN	__imp__GetDC@4:PROC
EXTRN	__imp__ShowCursor@4:PROC
EXTRN	__imp__ChangeDisplaySettingsA@8:PROC
EXTRN	__imp__sndPlaySoundA@8:PROC
EXTRN	__imp__timeGetTime@0:PROC
EXTRN	__imp__glBindTexture@8:PROC
EXTRN	__imp__glGenTextures@8:PROC
EXTRN	__imp__glRects@16:PROC
EXTRN	__imp__glTexImage2D@36:PROC
EXTRN	__imp__glTexParameteri@12:PROC
EXTRN	_su_render_song@4:PROC
EXTRN	__fltused:DWORD
_BSS	SEGMENT
?music@@3PAFA DW 0776916H DUP (?)			; music
_BSS	ENDS
;	COMDAT __real@4f800000
CONST	SEGMENT
__real@4f800000 DD 04f800000r			; 4.29497e+09
CONST	ENDS
;	COMDAT __real@433f0000
CONST	SEGMENT
__real@433f0000 DD 0433f0000r			; 191
CONST	ENDS
;	COMDAT __real@3a83126f
CONST	SEGMENT
__real@3a83126f DD 03a83126fr			; 0.001
CONST	ENDS
;	COMDAT ??_C@_0M@MLICAPOF@glUniform1f@
CONST	SEGMENT
??_C@_0M@MLICAPOF@glUniform1f@ DB 'glUniform1f', 00H	; `string'
CONST	ENDS
;	COMDAT ??_C@_0N@ICBDHBI@glUseProgram@
CONST	SEGMENT
??_C@_0N@ICBDHBI@glUseProgram@ DB 'glUseProgram', 00H	; `string'
CONST	ENDS
;	COMDAT ??_C@_0O@COHJKDBH@glDrawBuffers@
CONST	SEGMENT
??_C@_0O@COHJKDBH@glDrawBuffers@ DB 'glDrawBuffers', 00H ; `string'
CONST	ENDS
;	COMDAT ??_C@_0BF@ENLMLILA@glFramebufferTexture@
CONST	SEGMENT
??_C@_0BF@ENLMLILA@glFramebufferTexture@ DB 'glFramebufferTexture', 00H ; `string'
CONST	ENDS
;	COMDAT ??_C@_0BK@OJDINAOA@glFramebufferRenderbuffer@
CONST	SEGMENT
??_C@_0BK@OJDINAOA@glFramebufferRenderbuffer@ DB 'glFramebufferRenderbuff'
	DB	'er', 00H					; `string'
CONST	ENDS
;	COMDAT ??_C@_0BG@EOIILGMJ@glRenderbufferStorage@
CONST	SEGMENT
??_C@_0BG@EOIILGMJ@glRenderbufferStorage@ DB 'glRenderbufferStorage', 00H ; `string'
CONST	ENDS
;	COMDAT ??_C@_0BD@EPOPJGFA@glBindRenderbuffer@
CONST	SEGMENT
??_C@_0BD@EPOPJGFA@glBindRenderbuffer@ DB 'glBindRenderbuffer', 00H ; `string'
CONST	ENDS
;	COMDAT ??_C@_0BD@MIGEDNGJ@glGenRenderbuffers@
CONST	SEGMENT
??_C@_0BD@MIGEDNGJ@glGenRenderbuffers@ DB 'glGenRenderbuffers', 00H ; `string'
CONST	ENDS
;	COMDAT ??_C@_0BC@CJMIBNO@glBindFramebuffer@
CONST	SEGMENT
??_C@_0BC@CJMIBNO@glBindFramebuffer@ DB 'glBindFramebuffer', 00H ; `string'
CONST	ENDS
;	COMDAT ??_C@_0BC@FAPEBGID@glGenFramebuffers@
CONST	SEGMENT
??_C@_0BC@FAPEBGID@glGenFramebuffers@ DB 'glGenFramebuffers', 00H ; `string'
CONST	ENDS
;	COMDAT ??_C@_0BH@BOJGDFJN@glCreateShaderProgramv@
CONST	SEGMENT
??_C@_0BH@BOJGDFJN@glCreateShaderProgramv@ DB 'glCreateShaderProgramv', 00H ; `string'
CONST	ENDS
;	COMDAT ??_C@_06GGHJAEBN@static@
CONST	SEGMENT
??_C@_06GGHJAEBN@static@ DB 'static', 00H		; `string'
CONST	ENDS
_DATA	SEGMENT
?fragmentShader@@3PBDB DD FLAT:??_C@_0ONB@IFODBBKO@?$CDversion?5330?6layout?$CIlocation?$DN0?$CJ@ ; fragmentShader
?imageShader@@3PBDB DD FLAT:??_C@_0BLM@BIHFLBJO@?$CDversion?5330?6layout?$CIlocation?$DN0?$CJ@ ; imageShader
?screenSettings@@3U_devicemodeA@@A	ORG $+32		; screenSettings
	DW	00H
	DW	00H
	DW	09cH
	DW	00H
	DD	01c0000H
	DW	00H
	ORG $+14
	DW	00H
	DW	00H
	DW	00H
	DW	00H
	DW	00H
	ORG $+32
	DW	00H
	DD	020H
	DD	0780H
	DD	0438H
	DD	00H
	DD	00H
	DD	00H
	DD	00H
	DD	00H
	DD	00H
	DD	00H
	DD	00H
	DD	00H
	DD	00H
_DATA	ENDS
; Function compile flags: /Ogspy
; File C:\Users\Tonik\source\repos\asm24-4k\g4k_OGLShader\src\main_win_rel.cpp
;	COMDAT ?entrypoint@@YGXXZ
_TEXT	SEGMENT
_frameBufferId$ = -64					; size = 4
_renderTexture$ = -60					; size = 4
_depthbuffer$ = -56					; size = 4
_hDC$1$ = -52						; size = 4
_currentTime$1$ = -52					; size = 4
_drawBuffers$ = -48					; size = 4
tv277 = -44						; size = 4
_hWnd$1$ = -44						; size = 4
_to$1$ = -40						; size = 4
_fsId$1$ = -36						; size = 4
_imgFsId$1$ = -32					; size = 4
_msg$ = -28						; size = 28
?entrypoint@@YGXXZ PROC					; entrypoint, COMDAT

; 73   : {

	sub	esp, 64					; 00000040H
	push	ebp

; 74   :     // Do NOT do this
; 75   :     // SetProcessDpiAwarenessContext( DPI_AWARENESS_CONTEXT_SYSTEM_AWARE );
; 76   : 
; 77   :     // full screen
; 78   :     if( ChangeDisplaySettings(&screenSettings,CDS_FULLSCREEN)!=DISP_CHANGE_SUCCESSFUL) return; 

	mov	ebp, DWORD PTR __imp__ChangeDisplaySettingsA@8
	push	4
	push	OFFSET ?screenSettings@@3U_devicemodeA@@A
	call	ebp
	test	eax, eax
	jne	$LN1@entrypoint

; 79   :  
; 80   :     // create window
; 81   :     HWND hWnd = CreateWindow( "static",0,WS_POPUP|WS_VISIBLE,0,0,XRES,YRES,0,0,0,0);

	push	ebx
	push	esi
	push	edi
	push	eax
	push	eax
	push	eax
	push	eax
	push	1080					; 00000438H
	mov	ebp, 1920				; 00000780H
	push	ebp
	push	eax
	push	eax
	push	-1879048192				; 90000000H
	push	eax
	push	OFFSET ??_C@_06GGHJAEBN@static@
	push	eax
	call	DWORD PTR __imp__CreateWindowExA@48

; 82   :     HDC hDC = GetDC(hWnd);

	push	eax
	mov	DWORD PTR _hWnd$1$[esp+84], eax
	call	DWORD PTR __imp__GetDC@4
	mov	ebx, eax

; 83   :     // initalize opengl
; 84   :     SetPixelFormat(hDC,ChoosePixelFormat(hDC,&pfd),&pfd);

	mov	eax, OFFSET ?pfd@@3UtagPIXELFORMATDESCRIPTOR@@B
	push	eax
	push	eax
	push	ebx
	mov	DWORD PTR _hDC$1$[esp+92], ebx
	call	DWORD PTR __imp__ChoosePixelFormat@8
	push	eax
	push	ebx
	call	DWORD PTR __imp__SetPixelFormat@12

; 85   :     wglMakeCurrent(hDC,wglCreateContext(hDC));

	push	ebx
	call	DWORD PTR __imp__wglCreateContext@4
	push	eax
	push	ebx
	call	DWORD PTR __imp__wglMakeCurrent@8

; 86   : 
; 87   :     //wglSwapLayerBuffers( hDC, WGL_SWAP_MAIN_PLANE ); //SwapBuffers( hDC );
; 88   : 
; 89   :     // init opengl
; 90   :     const GLuint fsId = ((PFNGLCREATESHADERPROGRAMVPROC)wglGetProcAddress("glCreateShaderProgramv"))(GL_FRAGMENT_SHADER, 1, &fragmentShader);

	mov	ebx, DWORD PTR __imp__wglGetProcAddress@4
	mov	edi, 35632				; 00008b30H
	push	OFFSET ?fragmentShader@@3PBDB
	push	1
	push	edi
	mov	esi, OFFSET ??_C@_0BH@BOJGDFJN@glCreateShaderProgramv@
	push	esi
	call	ebx
	call	eax

; 91   :     const GLuint imgFsId = ((PFNGLCREATESHADERPROGRAMVPROC)wglGetProcAddress("glCreateShaderProgramv"))(GL_FRAGMENT_SHADER, 1, &imageShader);

	push	OFFSET ?imageShader@@3PBDB
	push	1
	push	edi
	push	esi
	mov	DWORD PTR _fsId$1$[esp+96], eax
	call	ebx
	call	eax
	mov	DWORD PTR _imgFsId$1$[esp+80], eax

; 92   : 
; 93   :     GLuint frameBufferId = 0;

	xor	esi, esi

; 94   :     ((PFNGLGENFRAMEBUFFERSPROC)wglGetProcAddress("glGenFramebuffers"))(1, &frameBufferId);

	lea	eax, DWORD PTR _frameBufferId$[esp+80]
	mov	DWORD PTR _frameBufferId$[esp+80], esi
	push	eax
	push	1
	push	OFFSET ??_C@_0BC@FAPEBGID@glGenFramebuffers@
	call	ebx
	call	eax

; 95   :     ((PFNGLBINDFRAMEBUFFERPROC)wglGetProcAddress("glBindFramebuffer"))(GL_FRAMEBUFFER, frameBufferId);

	push	DWORD PTR _frameBufferId$[esp+80]
	push	36160					; 00008d40H
	push	OFFSET ??_C@_0BC@CJMIBNO@glBindFramebuffer@
	call	ebx
	call	eax

; 96   : 
; 97   :     GLuint renderTexture;
; 98   :     glGenTextures(1, &renderTexture);

	lea	eax, DWORD PTR _renderTexture$[esp+80]
	push	eax
	push	1
	call	DWORD PTR __imp__glGenTextures@8

; 99   :     glBindTexture(GL_TEXTURE_2D, renderTexture);

	push	DWORD PTR _renderTexture$[esp+80]
	mov	edi, 3553				; 00000de1H
	push	edi
	call	DWORD PTR __imp__glBindTexture@8

; 100  :     glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, XRES, YRES, 0, GL_RGB, GL_UNSIGNED_BYTE, 0);

	push	esi
	push	5121					; 00001401H
	mov	eax, 6407				; 00001907H
	push	eax
	push	esi
	push	1080					; 00000438H
	push	ebp
	push	eax
	push	esi
	push	edi
	call	DWORD PTR __imp__glTexImage2D@36

; 101  :     glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);

	mov	esi, DWORD PTR __imp__glTexParameteri@12
	mov	edi, 9728				; 00002600H
	push	edi
	push	10240					; 00002800H
	push	3553					; 00000de1H
	call	esi

; 102  :     glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);

	push	edi
	push	10241					; 00002801H
	push	3553					; 00000de1H
	call	esi

; 103  :     glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP);

	mov	edi, 10496				; 00002900H
	push	edi
	push	10242					; 00002802H
	push	3553					; 00000de1H
	call	esi

; 104  :     glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP);

	push	edi
	push	10243					; 00002803H
	push	3553					; 00000de1H
	call	esi

; 105  : 
; 106  :     GLuint depthbuffer;
; 107  :     ((PFNGLGENRENDERBUFFERSPROC)wglGetProcAddress("glGenRenderbuffers"))(1, &depthbuffer);

	lea	eax, DWORD PTR _depthbuffer$[esp+80]
	push	eax
	push	1
	push	OFFSET ??_C@_0BD@MIGEDNGJ@glGenRenderbuffers@
	call	ebx
	call	eax

; 108  :     ((PFNGLBINDRENDERBUFFERPROC)wglGetProcAddress("glBindRenderbuffer"))(GL_RENDERBUFFER, depthbuffer);

	push	DWORD PTR _depthbuffer$[esp+80]
	mov	esi, 36161				; 00008d41H
	push	esi
	push	OFFSET ??_C@_0BD@EPOPJGFA@glBindRenderbuffer@
	call	ebx
	call	eax

; 109  :     ((PFNGLRENDERBUFFERSTORAGEPROC)wglGetProcAddress("glRenderbufferStorage"))(GL_RENDERBUFFER, GL_DEPTH_COMPONENT, XRES, YRES);

	push	1080					; 00000438H
	push	ebp
	push	6402					; 00001902H
	push	esi
	push	OFFSET ??_C@_0BG@EOIILGMJ@glRenderbufferStorage@
	call	ebx
	call	eax

; 110  :     ((PFNGLFRAMEBUFFERRENDERBUFFERPROC)wglGetProcAddress("glFramebufferRenderbuffer"))(GL_FRAMEBUFFER, GL_DEPTH_ATTACHMENT, GL_RENDERBUFFER, depthbuffer);

	push	DWORD PTR _depthbuffer$[esp+80]
	lea	ebp, DWORD PTR [esi-1]
	push	esi
	push	36096					; 00008d00H
	push	ebp
	push	OFFSET ??_C@_0BK@OJDINAOA@glFramebufferRenderbuffer@
	call	ebx
	call	eax

; 111  : 
; 112  :     ((PFNGLFRAMEBUFFERTEXTUREPROC)wglGetProcAddress("glFramebufferTexture"))(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, renderTexture, 0);

	push	0
	push	DWORD PTR _renderTexture$[esp+84]
	add	esi, -97				; ffffff9fH
	push	esi
	push	ebp
	push	OFFSET ??_C@_0BF@ENLMLILA@glFramebufferTexture@
	call	ebx
	call	eax

; 113  :     GLenum drawBuffers[1] = { GL_COLOR_ATTACHMENT0 };
; 114  :     ((PFNGLDRAWBUFFERSPROC)wglGetProcAddress("glDrawBuffers"))(1, drawBuffers);

	lea	eax, DWORD PTR _drawBuffers$[esp+80]
	mov	DWORD PTR _drawBuffers$[esp+80], esi
	push	eax
	push	1
	push	OFFSET ??_C@_0O@COHJKDBH@glDrawBuffers@
	call	ebx
	call	eax

; 115  : 
; 116  :     // init music
; 117  :     su_render_song(music + 22);

	push	OFFSET ?music@@3PAFA+44
	call	_su_render_song@4

; 118  :     memcpy(music, wavHeader, 44);

	push	11					; 0000000bH
	pop	ecx
	mov	esi, OFFSET ?wavHeader@@3QBHB
	mov	edi, OFFSET ?music@@3PAFA
	rep movsd

; 119  :     
; 120  :     ShowCursor(0);

	mov	esi, DWORD PTR __imp__ShowCursor@4
	push	0
	call	esi

; 121  :     
; 122  :     sndPlaySound((const char*)&music, SND_ASYNC | SND_MEMORY | SND_LOOP);

	push	13					; 0000000dH
	push	OFFSET ?music@@3PAFA
	call	DWORD PTR __imp__sndPlaySoundA@8

; 123  : 
; 124  :     MSG msg;
; 125  :     long to = timeGetTime();

	call	DWORD PTR __imp__timeGetTime@0
	mov	edi, DWORD PTR __imp__glRects@16
	mov	ebp, DWORD PTR _hDC$1$[esp+80]
	mov	DWORD PTR _to$1$[esp+80], eax
	mov	esi, DWORD PTR _hWnd$1$[esp+80]
$LL4@entrypoint:

; 126  :     float currentTime = 0.f;
; 127  :     float endTime = (SU_LENGTH_IN_SAMPLES * 2 + SU_SAMPLES_PER_ROW * SU_ROWS_PER_PATTERN * 7) / SU_SAMPLE_RATE;
; 128  :     do 
; 129  :     {
; 130  :         PeekMessage(&msg,hWnd,0,0,true);

	push	1
	push	0
	push	0
	push	esi
	lea	eax, DWORD PTR _msg$[esp+96]
	push	eax
	call	DWORD PTR __imp__PeekMessageA@20

; 131  :         currentTime = (float)(timeGetTime() - to) * 0.001f;

	call	DWORD PTR __imp__timeGetTime@0
	sub	eax, DWORD PTR _to$1$[esp+80]
	mov	DWORD PTR tv277[esp+80], eax
	fild	DWORD PTR tv277[esp+80]
	jns	SHORT $LN14@entrypoint
	fadd	DWORD PTR __real@4f800000
$LN14@entrypoint:

; 132  : 
; 133  :         ((PFNGLBINDFRAMEBUFFERPROC)wglGetProcAddress("glBindFramebuffer"))(GL_FRAMEBUFFER, frameBufferId);

	push	DWORD PTR _frameBufferId$[esp+80]
	fmul	DWORD PTR __real@3a83126f
	push	36160					; 00008d40H
	push	OFFSET ??_C@_0BC@CJMIBNO@glBindFramebuffer@
	fstp	DWORD PTR _currentTime$1$[esp+92]
	call	ebx
	call	eax

; 134  :         ((PFNGLUSEPROGRAMPROC)wglGetProcAddress("glUseProgram"))(fsId);

	push	DWORD PTR _fsId$1$[esp+80]
	push	OFFSET ??_C@_0N@ICBDHBI@glUseProgram@
	call	ebx
	call	eax

; 135  :         ((PFNGLUNIFORM1FPROC)wglGetProcAddress("glUniform1f"))(0, currentTime);

	fld	DWORD PTR _currentTime$1$[esp+80]
	push	ecx
	fstp	DWORD PTR [esp]
	push	0
	push	OFFSET ??_C@_0M@MLICAPOF@glUniform1f@
	call	ebx
	call	eax

; 136  :         glRects( -1, -1, 1, 1 );

	push	1
	push	1
	push	-1
	push	-1
	call	edi

; 137  : 
; 138  :         ((PFNGLBINDFRAMEBUFFERPROC)wglGetProcAddress("glBindFramebuffer"))(GL_FRAMEBUFFER, 0);

	push	0
	push	36160					; 00008d40H
	push	OFFSET ??_C@_0BC@CJMIBNO@glBindFramebuffer@
	call	ebx
	call	eax

; 139  :         ((PFNGLUSEPROGRAMPROC)wglGetProcAddress("glUseProgram"))(imgFsId);

	push	DWORD PTR _imgFsId$1$[esp+80]
	push	OFFSET ??_C@_0N@ICBDHBI@glUseProgram@
	call	ebx
	call	eax

; 140  :         glBindTexture(GL_TEXTURE_2D, renderTexture);

	push	DWORD PTR _renderTexture$[esp+80]
	push	3553					; 00000de1H
	call	DWORD PTR __imp__glBindTexture@8

; 141  :         glRects(-1, -1, 1, 1);

	push	1
	push	1
	push	-1
	push	-1
	call	edi

; 142  : 
; 143  :         wglSwapLayerBuffers( hDC, WGL_SWAP_MAIN_PLANE );

	push	1
	push	ebp
	call	DWORD PTR __imp__wglSwapLayerBuffers@8

; 144  :         Sleep(1);

	push	1
	call	DWORD PTR __imp__Sleep@4

; 145  :     }while( (msg.message!=WM_KEYDOWN || msg.wParam!=VK_ESCAPE) && currentTime < endTime);

	cmp	DWORD PTR _msg$[esp+84], 256		; 00000100H
	jne	SHORT $LN7@entrypoint
	cmp	DWORD PTR _msg$[esp+88], 27		; 0000001bH
	je	SHORT $LN6@entrypoint
$LN7@entrypoint:
	fld	DWORD PTR _currentTime$1$[esp+80]
	fcomp	DWORD PTR __real@433f0000
	fnstsw	ax
	test	ah, 5
	jnp	$LL4@entrypoint
$LN6@entrypoint:

; 146  : 
; 147  :     ChangeDisplaySettings( 0, 0 );

	mov	ebp, DWORD PTR __imp__ChangeDisplaySettingsA@8
	xor	ebx, ebx
	push	ebx
	push	ebx
	call	ebp

; 148  :     ShowCursor(1);

	mov	esi, DWORD PTR __imp__ShowCursor@4
	push	1
	call	esi

; 149  : 
; 150  :     ExitProcess(0);

	push	ebx
	call	DWORD PTR __imp__ExitProcess@4
	pop	edi
	pop	esi
	pop	ebx
$LN17@entrypoint:
$LN1@entrypoint:
	pop	ebp

; 151  : }

	add	esp, 64					; 00000040H
	ret	0
$LN15@entrypoint:
?entrypoint@@YGXXZ ENDP					; entrypoint
_TEXT	ENDS
END
