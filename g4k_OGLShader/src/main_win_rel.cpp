//--------------------------------------------------------------------------//
// iq / rgba  .  tiny codes  .  2008/2021                                   //
//--------------------------------------------------------------------------//

#define WIN32_LEAN_AND_MEAN
#define WIN32_EXTRA_LEAN
#include <windows.h>
#include <mmsystem.h>
#include <GL/gl.h>
#include <math.h>
#include "main.h"
#include "glext.h"
#include "fragmentShader.inl"
#include "imageShader.h"
#include "basssong-short.h"

//----------------------------------------------------------------------------

#ifdef __cplusplus
extern "C" 
{
#endif
int  _fltused = 0;
#ifdef __cplusplus
}
#endif

static const PIXELFORMATDESCRIPTOR pfd = {
    sizeof(PIXELFORMATDESCRIPTOR),
    1,
    PFD_DRAW_TO_WINDOW|PFD_SUPPORT_OPENGL|PFD_DOUBLEBUFFER,
    PFD_TYPE_RGBA,
    32, 0, 0, 0, 0, 0, 0, 
    0,  0, 0, 0, 0, 0, 0,
    32, 
    0, 
    0,
    PFD_MAIN_PLANE,
    0, 0, 0, 0 };

static const int wavHeader[11] = {
    0x46464952,
    SU_BUFFER_LENGTH + 36,
    0x45564157,
    0x20746D66,
    16,
    WAVE_FORMAT_PCM | (SU_CHANNEL_COUNT << 16),
    SU_SAMPLE_RATE,
    SU_SAMPLE_RATE * SU_CHANNEL_COUNT * sizeof(short),
    (SU_CHANNEL_COUNT * sizeof(short)) | ((8 * sizeof(short)) << 16),
    0x61746164,
    SU_BUFFER_LENGTH * sizeof(short) };

static short music[SU_BUFFER_LENGTH + 22];

static DEVMODE screenSettings = { {0},
    #if _MSC_VER < 1400
    0,0,148,0,0x001c0000,{0},0,0,0,0,0,0,0,0,0,{0},0,32,XRES,YRES,0,0,      // Visual C++ 6.0
    #else
    0,0,156,0,0x001c0000,{0},0,0,0,0,0,{0},0,32,XRES,YRES,{0}, 0,           // Visual Studio 2005
    #endif
    #if(WINVER >= 0x0400)
    0,0,0,0,0,0,
    #if (WINVER >= 0x0500) || (_WIN32_WINNT >= 0x0400)
    0,0
    #endif
    #endif
    };

//----------------------------------------------------------------------------

void entrypoint( void )
{
    // Do NOT do this
    // SetProcessDpiAwarenessContext( DPI_AWARENESS_CONTEXT_SYSTEM_AWARE );

    // full screen
    if( ChangeDisplaySettings(&screenSettings,CDS_FULLSCREEN)!=DISP_CHANGE_SUCCESSFUL) return; ShowCursor( 0 );
    // create window
    HWND hWnd = CreateWindow( "static",0,WS_POPUP|WS_VISIBLE,0,0,XRES,YRES,0,0,0,0);
    HDC hDC = GetDC(hWnd);
    // initalize opengl
    SetPixelFormat(hDC,ChoosePixelFormat(hDC,&pfd),&pfd);
    wglMakeCurrent(hDC,wglCreateContext(hDC));

    //wglSwapLayerBuffers( hDC, WGL_SWAP_MAIN_PLANE ); //SwapBuffers( hDC );

    // init intro
    const unsigned int fsId = ((PFNGLCREATESHADERPROGRAMVPROC)wglGetProcAddress("glCreateShaderProgramv"))(GL_FRAGMENT_SHADER, 1, &fragmentShader);
    ((PFNGLUSEPROGRAMPROC)wglGetProcAddress("glUseProgram"))(fsId);

    // init music
    su_render_song(music + 22);
    memcpy(music, wavHeader, 44);
    sndPlaySound((const char*)&music, SND_ASYNC | SND_MEMORY | SND_LOOP);

    MSG msg;
    long to = timeGetTime();
    float currentTime = 0.f;
    float endTime = (SU_LENGTH_IN_SAMPLES * 2 + SU_SAMPLES_PER_ROW * SU_ROWS_PER_PATTERN * 7) / SU_SAMPLE_RATE;
    do 
    {
        PeekMessage(&msg,hWnd,0,0,true);
        currentTime = (float)(timeGetTime() - to) * 0.001f;
        ((PFNGLUNIFORM1FPROC)wglGetProcAddress("glUniform1f"))(0, currentTime);
        glRects( -1, -1, 1, 1 );
        wglSwapLayerBuffers( hDC, WGL_SWAP_MAIN_PLANE ); //SwapBuffers( hDC );
        Sleep(1);
    }while( (msg.message!=WM_KEYDOWN || msg.wParam!=VK_ESCAPE) && currentTime < endTime);

    ChangeDisplaySettings( 0, 0 );
    ShowCursor(1);

    ExitProcess(0);
}
