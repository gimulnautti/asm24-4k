; Listing generated by Microsoft (R) Optimizing Compiler Version 19.40.33812.0 

	TITLE	C:\Users\Tonik\source\repos\asm24-4k\g4k_OGLShader\bin\Release\main_win_rel.obj
	.686P
	.XMM
	include listing.inc
	.model	flat

INCLUDELIB LIBCMT
INCLUDELIB OLDNAMES

PUBLIC	??_C@_0ODH@DNONAHLN@?$CDversion?5430?6uniform?5float?5v?$DLma@ ; `string'
PUBLIC	??_C@_0BLD@CBMBIJDB@?$CDversion?5430?6varying?5vec2?5m?$DLuni@ ; `string'
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
;	COMDAT ??_C@_0BLD@CBMBIJDB@?$CDversion?5430?6varying?5vec2?5m?$DLuni@
CONST	SEGMENT
??_C@_0BLD@CBMBIJDB@?$CDversion?5430?6varying?5vec2?5m?$DLuni@ DB '#versi'
	DB	'on 430', 0aH, 'varying vec2 m;uniform sampler2D v;vec4 x(vec2'
	DB	' m){float p=1.;vec4 y=vec4(0);for(float f=-5.;f<=5.;f+=1.)for'
	DB	'(float i=-5.;i<=5.;i+=1.){vec4 r=texture2D(v,m+vec2(f,i)*(vec'
	DB	'2(7)/vec2(1920,1080)));if(max(r.x,max(r.y,r.z))>.8){float v=l'
	DB	'ength(vec2(f,i))+1.;vec4 m=max(r*128./pow(v,2.),vec4(0));if(m'
	DB	'ax(m.x,max(m.y,m.z))>.9)y+=m,p+=1.;}}return y/p;}void main(){'
	DB	'vec2 r=m.xy/vec2(2).xy+vec2(.5);gl_FragColor=texture2D(v,r)+.'
	DB	'05*x(r);}', 00H				; `string'
CONST	ENDS
;	COMDAT ??_C@_0ODH@DNONAHLN@?$CDversion?5430?6uniform?5float?5v?$DLma@
CONST	SEGMENT
??_C@_0ODH@DNONAHLN@?$CDversion?5430?6uniform?5float?5v?$DLma@ DB '#versi'
	DB	'on 430', 0aH, 'uniform float v;mat3 n(float v){float m=sin(v)'
	DB	';v=cos(v);return mat3(vec3(1,0,0),vec3(0,v,m),vec3(0,-m,v));}'
	DB	'mat3 f(float v){float m=sin(v);v=cos(v);return mat3(vec3(v,0,'
	DB	'm),vec3(0,1,0),vec3(-m,0,v));}vec3 i;', 0aH, '#define BPS 0.5'
	DB	'0420168', 0aH, 'float f(){return v+.05;}float s(float v){v*=B'
	DB	'PS;return smoothstep(0.,1.,1.-mod(f(),v)/v);}float n(){float '
	DB	'v=32.*BPS;return mod(f(),v)/v<.5?0.:1.;}float t(float v){v*=B'
	DB	'PS;return f()<v?0.:1.;}float f(vec3 v,vec2 m){return length(v'
	DB	'ec2(length(v.xz)-m.x,v.y))-m.y;}float n(vec3 v,vec3 m){v=abs('
	DB	'v)-m;return length(max(v,0.))+min(max(v.x,max(v.y,v.z)),0.);}'
	DB	'vec3 s(vec3 v,vec3 m){return v-m*round(v/m);}float t(float v,'
	DB	'float m){return max(v,-m);}void m(inout vec3 v,inout float m)'
	DB	'{float f=dot(v,v);if(f<1.7){float s=1.7/f;v*=s;m*=s;}}void r('
	DB	'inout vec3 v,inout float m){v=clamp(v,-1.,1.)*2.-v;}float m(v'
	DB	'ec3 f){if(t(138.)>.9&&t(160.)<.9||t(368.)>.9)return 1e4;i=f;f'
	DB	'loat s=-.85-sin(v*.002)*.45;vec3 c=f;float y=20.;for(int v=0;'
	DB	'v<13;v++)r(f,y),m(f,y),f=s*f+c,y=y*abs(s)+1.;s=length(f);retu'
	DB	'rn s/abs(y);}float r(vec3 m){if(t(124.)>.9&&t(160.)<.9||t(232'
	DB	'.)>.9&&t(240.)<.9||t(256.)>.9&&t(272.)<.9||t(288.)>.9&&t(304.'
	DB	')<.9||t(336.)>.9&&t(380.)<.9){vec3 s=vec3(6,0,0);float y=6.28'
	DB	'/15.+sin(v*.35)*.1,i=1e4;for(float r=0.;r<3.;r+=1.)for(float '
	DB	'x=0.;x<15.;x+=1.){vec3 c=m-vec3(0,-2.+r*2.,0)-f(x*y+v*.65)*s;'
	DB	'i=min(i,n(f(-y)*c,vec3(.4)));}return i;}return 1e4;}float d(v'
	DB	'ec3 y){float i=m((y+vec3(30,cos(v*.0025)*30.,1))*(sin(v*.025)'
	DB	'+1.5)*.025),c=6.+t(140.)*2.,x=2.5+t(128.)*3.-t(140.)*2.;i=min'
	DB	'(t(i,f(y,vec2(c,x))),length(s(y+vec3(sin(v)*1.6,1.5,cos(v)*1.'
	DB	'6),vec3(6,5,6)))-.7);vec3 l=vec3(6,6,2)*(1.5-n()*.5);x=t(i,n('
	DB	's(vec3(0,0,5.*sin(v*.1))+y*n(v*.1),vec3(10)),l));return min(x'
	DB	',r(y));}vec3 x(vec3 v){vec2 m=vec2(1,-1)*.5773;return normali'
	DB	'ze(m.xyy*d(v+m.xyy*5e-4)+m.yyx*d(v+m.yyx*5e-4)+m.yxy*d(v+m.yx'
	DB	'y*5e-4)+m.xxx*d(v+m.xxx*5e-4));}float c(float v){vec3 m=fract'
	DB	'(vec3(v)*.1031);m+=dot(m,m.yzx+19.19);return fract((m.x+m.y)*'
	DB	'm.z);}float c(vec3 v,vec3 m){float f=0.;for(int i=0;i<9;i++){'
	DB	'float s=c(float(i))*2.5;f+=(s-max(d(v+m*s),0.))/2.5*2.5;}retu'
	DB	'rn clamp(1.-f/9.,.05,1.);}vec3 e(vec3 v){float m=sin(v.x*7.)*'
	DB	'.4+.6;return vec3(1,m,m*.75);}int c(){return 4+int(t(128.))*3'
	DB	';}int d(){return 1+int(t(124.))*4-int(t(160.))*3;}float e(){r'
	DB	'eturn 6.-t(124.)*2.5;}vec3 h(float v){return vec3(mod(v,7.)/1'
	DB	'4.,mod(v,5.)/5.,.5+mod(v,3.)/6.);}vec2 p(vec3 m){float f=s(1.'
	DB	')*.05+.05+t(120.)*.05,i=1e4,y=i,x=float(-c())*e()/2.+6.,l=0.;'
	DB	'for(int s=0;s<c();++s){float r=float(s);for(int s=0;s<d();++s'
	DB	'){float c=float(s+1);i=min(i,n(m+vec3(c*e()+3.*sin(v*.2*c)+co'
	DB	's(m.z*.5),x+e()*r+sin(m.z*.5),x+r*e()*2.*sin(v*.25*c)),vec3(f'
	DB	',f,4.+t(120.)*6.)));if(i<y)l=float(d())*c+r,y=i;}}return vec2'
	DB	'(i,l);}vec3 c(vec3 v,vec3 m,float s){float f=0.;vec3 i;float '
	DB	'y=0.;for(int s=0;s<64;s++){i=m+f*v;vec2 c=p(i);float x=c.x;if'
	DB	'(x<1e-4){y=c.y;break;}else if(f>15.)break;f+=x;}return f<15.&'
	DB	'&f<s?h(y):vec3(0);}void main(){vec2 m=vec2(1920,1080);m=(-m.x'
	DB	'y+2.*gl_FragCoord.xy)/m.y;float f=.05*v+sin(v*.1)*m.y*sin(v*.'
	DB	'05)*2.;f*=n()*2.-1.;vec3 y=vec3(8.*cos(f),.6,8.*sin(f)),r=nor'
	DB	'malize(vec3(0,sin(v*.5),0)-y),l=normalize(cross(r,vec3(0,.6,.'
	DB	'5)));r=normalize(m.x*l+m.y*normalize(cross(l,r))+1.5*r);f=0.;'
	DB	'float t=1e5,z=0.;for(int v=0;v<128;v++){l=y+f*r;float m=d(l);'
	DB	'if(m<.00015){vec2 m=p(l);t=m.x;z=m.y;break;}else if(f>35.)bre'
	DB	'ak;f+=m;}vec3 B=vec3(0);if(f<35.){vec3 v=x(l);float f=clamp(d'
	DB	'ot(v,vec3(.7,1.2,.4)),0.,1.2);f*=f;f*=f;f*=s(16.);float m=.5+'
	DB	'.5*dot(v,vec3(0,.8,-.6));m*=s(16.);B=vec3(.2,.3,.5)*m+e(i)*ve'
	DB	'c3(.9,.8,.6)*f;B*=c(l,v);if(t<2.){float v=(2.-t)/2.;B+=v*v*v*'
	DB	'h(z)*(s(1.)*.5+.5);}B/=max(1.,l.z*.5);}B=sqrt(B);B=B*.5+.5*B*'
	DB	'B*(3.-2.*B);y=c(r,y,f);gl_FragColor=vec4(B,f)+vec4(y,0);}', 00H ; `string'
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
?fragmentShader@@3PBDB DD FLAT:??_C@_0ODH@DNONAHLN@?$CDversion?5430?6uniform?5float?5v?$DLma@ ; fragmentShader
?imageShader@@3PBDB DD FLAT:??_C@_0BLD@CBMBIJDB@?$CDversion?5430?6varying?5vec2?5m?$DLuni@ ; imageShader
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

; 79   :     ShowCursor( 0 );

	push	ebx
	push	esi
	push	edi
	xor	ebx, ebx
	push	ebx
	call	DWORD PTR __imp__ShowCursor@4

; 80   :     // create window
; 81   :     HWND hWnd = CreateWindow( "static",0,WS_POPUP|WS_VISIBLE,0,0,XRES,YRES,0,0,0,0);

	push	ebx
	push	ebx
	push	ebx
	push	ebx
	push	1080					; 00000438H
	mov	ebp, 1920				; 00000780H
	push	ebp
	push	ebx
	push	ebx
	push	-1879048192				; 90000000H
	push	ebx
	push	OFFSET ??_C@_06GGHJAEBN@static@
	push	ebx
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

; 119  :     sndPlaySound((const char*)&music, SND_ASYNC | SND_MEMORY | SND_LOOP);

	push	13					; 0000000dH
	mov	esi, OFFSET ?wavHeader@@3QBHB
	mov	edi, OFFSET ?music@@3PAFA
	rep movsd
	push	OFFSET ?music@@3PAFA
	call	DWORD PTR __imp__sndPlaySoundA@8

; 120  : 
; 121  :     MSG msg;
; 122  :     long to = timeGetTime();

	call	DWORD PTR __imp__timeGetTime@0
	mov	esi, DWORD PTR __imp__glRects@16
	mov	edi, DWORD PTR _hDC$1$[esp+80]
	mov	DWORD PTR _to$1$[esp+80], eax
	mov	ebp, DWORD PTR _hWnd$1$[esp+80]
$LL4@entrypoint:

; 123  :     float currentTime = 0.f;
; 124  :     float endTime = (SU_LENGTH_IN_SAMPLES * 2 + SU_SAMPLES_PER_ROW * SU_ROWS_PER_PATTERN * 7) / SU_SAMPLE_RATE;
; 125  :     do 
; 126  :     {
; 127  :         PeekMessage(&msg,hWnd,0,0,true);

	push	1
	push	0
	push	0
	push	ebp
	lea	eax, DWORD PTR _msg$[esp+96]
	push	eax
	call	DWORD PTR __imp__PeekMessageA@20

; 128  :         currentTime = (float)(timeGetTime() - to) * 0.001f;

	call	DWORD PTR __imp__timeGetTime@0
	sub	eax, DWORD PTR _to$1$[esp+80]
	mov	DWORD PTR tv277[esp+80], eax
	fild	DWORD PTR tv277[esp+80]
	jns	SHORT $LN14@entrypoint
	fadd	DWORD PTR __real@4f800000
$LN14@entrypoint:

; 129  : 
; 130  :         ((PFNGLBINDFRAMEBUFFERPROC)wglGetProcAddress("glBindFramebuffer"))(GL_FRAMEBUFFER, frameBufferId);

	push	DWORD PTR _frameBufferId$[esp+80]
	fmul	DWORD PTR __real@3a83126f
	push	36160					; 00008d40H
	push	OFFSET ??_C@_0BC@CJMIBNO@glBindFramebuffer@
	fstp	DWORD PTR _currentTime$1$[esp+92]
	call	ebx
	call	eax

; 131  :         ((PFNGLUSEPROGRAMPROC)wglGetProcAddress("glUseProgram"))(fsId);

	push	DWORD PTR _fsId$1$[esp+80]
	push	OFFSET ??_C@_0N@ICBDHBI@glUseProgram@
	call	ebx
	call	eax

; 132  :         ((PFNGLUNIFORM1FPROC)wglGetProcAddress("glUniform1f"))(0, currentTime);

	fld	DWORD PTR _currentTime$1$[esp+80]
	push	ecx
	fstp	DWORD PTR [esp]
	push	0
	push	OFFSET ??_C@_0M@MLICAPOF@glUniform1f@
	call	ebx
	call	eax

; 133  :         glRects( -1, -1, 1, 1 );

	push	1
	push	1
	push	-1
	push	-1
	call	esi

; 134  : 
; 135  :         ((PFNGLBINDFRAMEBUFFERPROC)wglGetProcAddress("glBindFramebuffer"))(GL_FRAMEBUFFER, 0);

	push	0
	push	36160					; 00008d40H
	push	OFFSET ??_C@_0BC@CJMIBNO@glBindFramebuffer@
	call	ebx
	call	eax

; 136  :         ((PFNGLUSEPROGRAMPROC)wglGetProcAddress("glUseProgram"))(imgFsId);

	push	DWORD PTR _imgFsId$1$[esp+80]
	push	OFFSET ??_C@_0N@ICBDHBI@glUseProgram@
	call	ebx
	call	eax

; 137  :         glBindTexture(GL_TEXTURE_2D, renderTexture);

	push	DWORD PTR _renderTexture$[esp+80]
	push	3553					; 00000de1H
	call	DWORD PTR __imp__glBindTexture@8

; 138  :         glRects(-1, -1, 1, 1);

	push	1
	push	1
	push	-1
	push	-1
	call	esi

; 139  : 
; 140  :         wglSwapLayerBuffers( hDC, WGL_SWAP_MAIN_PLANE );

	push	1
	push	edi
	call	DWORD PTR __imp__wglSwapLayerBuffers@8

; 141  :         Sleep(1);

	push	1
	call	DWORD PTR __imp__Sleep@4

; 142  :     }while( (msg.message!=WM_KEYDOWN || msg.wParam!=VK_ESCAPE) && currentTime < endTime);

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

; 143  : 
; 144  :     ChangeDisplaySettings( 0, 0 );

	mov	ebp, DWORD PTR __imp__ChangeDisplaySettingsA@8
	xor	ebx, ebx
	push	ebx
	push	ebx
	call	ebp

; 145  :     ShowCursor(1);

	push	1
	call	DWORD PTR __imp__ShowCursor@4

; 146  : 
; 147  :     ExitProcess(0);

	push	ebx
	call	DWORD PTR __imp__ExitProcess@4
	pop	edi
	pop	esi
	pop	ebx
$LN17@entrypoint:
$LN1@entrypoint:
	pop	ebp

; 148  : }

	add	esp, 64					; 00000040H
	ret	0
$LN15@entrypoint:
?entrypoint@@YGXXZ ENDP					; entrypoint
_TEXT	ENDS
END
