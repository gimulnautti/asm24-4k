; Listing generated by Microsoft (R) Optimizing Compiler Version 19.40.33811.0 

	TITLE	C:\Users\Tonik\source\repos\asm24-4k\g4k_OGLShader\bin\Release\main_win_rel.obj
	.686P
	.XMM
	include listing.inc
	.model	flat

INCLUDELIB LIBCMT
INCLUDELIB OLDNAMES

PUBLIC	??_C@_0KDP@BCJAFIFF@?$CDversion?5430?6in?5vec2?5fragCoord?$DL@ ; `string'
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
CONST	ENDS
;	COMDAT ??_C@_0KDP@BCJAFIFF@?$CDversion?5430?6in?5vec2?5fragCoord?$DL@
CONST	SEGMENT
??_C@_0KDP@BCJAFIFF@?$CDversion?5430?6in?5vec2?5fragCoord?$DL@ DB '#versi'
	DB	'on 430', 0aH, 'in vec2 fragCoord;uniform float iGlobalTime;ou'
	DB	't vec4 fragColor;mat3 rotate_x(float a){float sa=sin(a);a=cos'
	DB	'(a);return mat3(vec3(1,0,0),vec3(0,a,sa),vec3(0,-sa,a));}vec3'
	DB	' mandelboxPosition;float sdTorus(vec3 p){vec2 t=vec2(6,2.5);r'
	DB	'eturn length(vec2(length(p.xz)-t.x,p.y))-t.y;}vec3 repeat(vec'
	DB	'3 pos,vec3 s){return pos-s*round(pos/s);}float opSubtraction('
	DB	'float d1,float d2){return max(d1,-d2);}void sphereFold(inout '
	DB	'vec3 z,inout float dz){float r2=dot(z,z);if(r2<1.7){float tem'
	DB	'p=1.7/r2;z*=temp;dz*=temp;}}void boxFold(inout vec3 z,inout f'
	DB	'loat dz){z=clamp(z,-1.,1.)*2.-z;}', 0aH, '#define MX 13', 0aH
	DB	'float mandelbox_de(vec3 z){mandelboxPosition=z;float Scale=-.'
	DB	'85-sin(iGlobalTime*.002)*.45;vec3 offset=z;float dr=20.;for(i'
	DB	'nt n=0;n<MX;n++)boxFold(z,dr),sphereFold(z,dr),z=Scale*z+offs'
	DB	'et,dr=dr*abs(Scale)+1.;Scale=length(z);return Scale/abs(dr);}'
	DB	'float sdBox(vec3 p){p=abs(p)-vec3(6,6,2);return length(max(p,'
	DB	'0.))+min(max(p.x,max(p.y,p.z)),0.);}float scene(vec3 pos){flo'
	DB	'at d1=mandelbox_de((pos+vec3(30,cos(iGlobalTime*.0025)*30.,1)'
	DB	')*(sin(iGlobalTime*.025)+1.5)*.025);d1=min(opSubtraction(d1,s'
	DB	'dTorus(pos)),length(repeat(pos+vec3(sin(iGlobalTime)*1.6,1.5,'
	DB	'cos(iGlobalTime)*1.6),vec3(6,5,6)))-.7);return opSubtraction('
	DB	'd1,sdBox(repeat(vec3(0,0,5.*sin(iGlobalTime*.1))+pos*rotate_x'
	DB	'(iGlobalTime*.1),vec3(10))));}vec3 calcNormal(vec3 pos){vec2 '
	DB	'e=vec2(1,-1)*.5773;return normalize(e.xyy*scene(pos+e.xyy*5e-'
	DB	'4)+e.yyx*scene(pos+e.yyx*5e-4)+e.yxy*scene(pos+e.yxy*5e-4)+e.'
	DB	'xxx*scene(pos+e.xxx*5e-4));}', 0aH, '#define HS .1031', 0aH, 'f'
	DB	'loat hash(float p){vec3 p3=fract(vec3(p)*HS);p3+=dot(p3,p3.yz'
	DB	'x+19.19);return fract((p3.x+p3.y)*p3.z);}float ambientOcclusi'
	DB	'on(vec3 p,vec3 n){float ao=0.;for(int i=0;i<10;i++){float l=h'
	DB	'ash(float(i))*2.5;ao+=(l-max(scene(p+n*l),0.))/2.5*2.5;}retur'
	DB	'n clamp(1.-ao/float(10),.05,1.);}vec3 stripes(vec3 pos){float'
	DB	' stripe=sin(pos.x*7.)*.4+.6;return vec3(1,stripe,stripe*.75);'
	DB	'}void main(){vec2 iResolution = vec2(1280.,720.);vec2 p=(-iRe'
	DB	'solution.xy+2.*gl_FragCoord.xy)/iResolution.y;float an=.05*iG'
	DB	'lobalTime+sin(iGlobalTime*.1)*p.y*sin(iGlobalTime*.05)*2.;vec'
	DB	'3 ro=vec3(8.*cos(an),.6,8.*sin(an)),ww=normalize(vec3(0,sin(i'
	DB	'GlobalTime*.5),0)-ro),uu=normalize(cross(ww,vec3(0,.6,.5)));u'
	DB	'u=normalize(p.x*uu+p.y*normalize(cross(uu,ww))+1.5*ww);an=0.;'
	DB	'for(int i=0;i<256;i++){vec3 pos=ro+an*uu;float h=scene(pos);i'
	DB	'f(h<.00015)break;else if(an>35.)break;an+=h;}ww=vec3(0);if(an'
	DB	'<35.){vec3 pos=ro+an*uu,nor=calcNormal(pos);float dif=clamp(d'
	DB	'ot(nor,vec3(.7,1.6,.4)),0.,1.2);dif*=dif;dif*=dif;ww=vec3(.2,'
	DB	'.3,.5)*(.5+.5*dot(nor,vec3(0,.8,-.6)))+stripes(mandelboxPosit'
	DB	'ion)*vec3(.9,.8,.6)*dif;ww*=ambientOcclusion(pos,nor);}ww=sqr'
	DB	't(ww);fragColor=vec4(ww,1);}', 00H		; `string'
CONST	ENDS
PUBLIC	?entrypoint@@YGXXZ				; entrypoint
PUBLIC	??_C@_06GGHJAEBN@static@			; `string'
PUBLIC	??_C@_0BH@BOJGDFJN@glCreateShaderProgramv@	; `string'
PUBLIC	??_C@_0N@ICBDHBI@glUseProgram@			; `string'
PUBLIC	??_C@_0M@MLICAPOF@glUniform1f@			; `string'
PUBLIC	__real@00000000
PUBLIC	__real@3ca3d70a
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
EXTRN	__imp__glRects@16:PROC
EXTRN	__fltused:DWORD
;	COMDAT __real@3ca3d70a
CONST	SEGMENT
__real@3ca3d70a DD 03ca3d70ar			; 0.02
CONST	ENDS
;	COMDAT __real@00000000
CONST	SEGMENT
__real@00000000 DD 000000000r			; 0
CONST	ENDS
;	COMDAT ??_C@_0M@MLICAPOF@glUniform1f@
CONST	SEGMENT
??_C@_0M@MLICAPOF@glUniform1f@ DB 'glUniform1f', 00H	; `string'
CONST	ENDS
;	COMDAT ??_C@_0N@ICBDHBI@glUseProgram@
CONST	SEGMENT
??_C@_0N@ICBDHBI@glUseProgram@ DB 'glUseProgram', 00H	; `string'
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
?fragmentShader@@3PBDB DD FLAT:??_C@_0KDP@BCJAFIFF@?$CDversion?5430?6in?5vec2?5fragCoord?$DL@ ; fragmentShader
	ORG $+4
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
	DD	0500H
	DD	02d0H
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
_currentTime$1$ = -36					; size = 4
_hWnd$1$ = -32						; size = 4
_msg$ = -28						; size = 28
?entrypoint@@YGXXZ PROC					; entrypoint, COMDAT

; 56   : {

	sub	esp, 36					; 00000024H
	push	esi

; 57   :     // Do NOT do this
; 58   :     // SetProcessDpiAwarenessContext( DPI_AWARENESS_CONTEXT_SYSTEM_AWARE );
; 59   : 
; 60   :     // full screen
; 61   :     if( ChangeDisplaySettings(&screenSettings,CDS_FULLSCREEN)!=DISP_CHANGE_SUCCESSFUL) return; ShowCursor( 0 );

	mov	esi, DWORD PTR __imp__ChangeDisplaySettingsA@8
	push	4
	push	OFFSET ?screenSettings@@3U_devicemodeA@@A
	call	esi
	test	eax, eax
	jne	$LN1@entrypoint
	push	ebx
	push	ebp
	xor	ebx, ebx
	push	ebx
	call	DWORD PTR __imp__ShowCursor@4

; 62   :     // create window
; 63   :     HWND hWnd = CreateWindow( "static",0,WS_POPUP|WS_VISIBLE,0,0,XRES,YRES,0,0,0,0);

	push	ebx
	push	ebx
	push	ebx
	push	ebx
	push	720					; 000002d0H
	push	1280					; 00000500H
	push	ebx
	push	ebx
	push	-1879048192				; 90000000H
	push	ebx
	push	OFFSET ??_C@_06GGHJAEBN@static@
	push	ebx
	call	DWORD PTR __imp__CreateWindowExA@48

; 64   :     HDC hDC = GetDC(hWnd);

	push	eax
	mov	DWORD PTR _hWnd$1$[esp+52], eax
	call	DWORD PTR __imp__GetDC@4
	mov	ebx, eax

; 65   :     // initalize opengl
; 66   :     SetPixelFormat(hDC,ChoosePixelFormat(hDC,&pfd),&pfd);

	mov	eax, OFFSET ?pfd@@3UtagPIXELFORMATDESCRIPTOR@@B
	push	eax
	push	eax
	push	ebx
	call	DWORD PTR __imp__ChoosePixelFormat@8
	push	eax
	push	ebx
	call	DWORD PTR __imp__SetPixelFormat@12

; 67   :     wglMakeCurrent(hDC,wglCreateContext(hDC));

	push	ebx
	call	DWORD PTR __imp__wglCreateContext@4
	push	eax
	push	ebx
	call	DWORD PTR __imp__wglMakeCurrent@8

; 68   : 
; 69   :     //wglSwapLayerBuffers( hDC, WGL_SWAP_MAIN_PLANE ); //SwapBuffers( hDC );
; 70   : 
; 71   :     // init intro
; 72   :     const unsigned int fsId = ((PFNGLCREATESHADERPROGRAMVPROC)wglGetProcAddress("glCreateShaderProgramv"))(GL_FRAGMENT_SHADER, 1, &fragmentShader);

	mov	ebp, DWORD PTR __imp__wglGetProcAddress@4
	push	OFFSET ?fragmentShader@@3PBDB
	push	1
	push	35632					; 00008b30H
	push	OFFSET ??_C@_0BH@BOJGDFJN@glCreateShaderProgramv@
	call	ebp
	call	eax

; 73   :     ((PFNGLUSEPROGRAMPROC)wglGetProcAddress("glUseProgram"))(fsId);

	push	eax
	push	OFFSET ??_C@_0N@ICBDHBI@glUseProgram@
	call	ebp
	call	eax

; 74   : 
; 75   :     MSG msg;
; 76   :     float currentTime = 0.f;

	fldz
	mov	esi, DWORD PTR _hWnd$1$[esp+48]
	fstp	DWORD PTR _currentTime$1$[esp+48]
$LL4@entrypoint:

; 77   :     do 
; 78   :     {
; 79   :         PeekMessage(&msg,hWnd,0,0,true);

	push	1
	push	0
	push	0
	push	esi
	lea	eax, DWORD PTR _msg$[esp+64]
	push	eax
	call	DWORD PTR __imp__PeekMessageA@20

; 80   :         currentTime += 0.02f;

	fld	DWORD PTR _currentTime$1$[esp+48]
	fadd	DWORD PTR __real@3ca3d70a

; 81   :         ((PFNGLUNIFORM1FPROC)wglGetProcAddress("glUniform1f"))(0, currentTime);

	push	ecx
	fst	DWORD PTR _currentTime$1$[esp+52]
	fstp	DWORD PTR [esp]
	push	0
	push	OFFSET ??_C@_0M@MLICAPOF@glUniform1f@
	call	ebp
	call	eax

; 82   :         glRects( -1, -1, 1, 1 );

	push	1
	push	1
	push	-1
	push	-1
	call	DWORD PTR __imp__glRects@16

; 83   :         wglSwapLayerBuffers( hDC, WGL_SWAP_MAIN_PLANE ); //SwapBuffers( hDC );

	push	1
	push	ebx
	call	DWORD PTR __imp__wglSwapLayerBuffers@8

; 84   :         Sleep(1);

	push	1
	call	DWORD PTR __imp__Sleep@4

; 85   :     }while( msg.message!=WM_KEYDOWN || msg.wParam!=VK_ESCAPE );

	cmp	DWORD PTR _msg$[esp+52], 256		; 00000100H
	jne	SHORT $LL4@entrypoint
	cmp	DWORD PTR _msg$[esp+56], 27		; 0000001bH
	jne	SHORT $LL4@entrypoint

; 86   : 
; 87   :     ChangeDisplaySettings( 0, 0 );

	mov	esi, DWORD PTR __imp__ChangeDisplaySettingsA@8
	xor	ebx, ebx
	push	ebx
	push	ebx
	call	esi

; 88   :     ShowCursor(1);

	push	1
	call	DWORD PTR __imp__ShowCursor@4

; 89   : 
; 90   :     ExitProcess(0);

	push	ebx
	call	DWORD PTR __imp__ExitProcess@4
	pop	ebp
	pop	ebx
$LN16@entrypoint:
$LN1@entrypoint:
	pop	esi

; 91   : }

	add	esp, 36					; 00000024H
	ret	0
$LN14@entrypoint:
?entrypoint@@YGXXZ ENDP					; entrypoint
_TEXT	ENDS
END
