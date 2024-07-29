//--------------------------------------------------------------------------//
// iq / rgba  .  tiny codes  .  2008/2021                                   //
//--------------------------------------------------------------------------//

#define WIN32_LEAN_AND_MEAN
#define WIN32_EXTRA_LEAN
#include <windows.h>
#include <windowsx.h>
#include <mmsystem.h>
#include <GL/gl.h>
#include <string.h>
#include <stdio.h>
#include <math.h>
#include "main.h"
#include "glext.h"
#include "fragmentShader.inl"
#include "imageShader.h"
#include "basssong-short.h"

//==============================================================================================

typedef struct
{
    //---------------
    HINSTANCE   hInstance;
    HDC         hDC;
    HGLRC       hRC;
    HWND        hWnd;
    //---------------
    int         full;
    //---------------
    char        wndclass[4];    // window class and title :)
    //---------------
}WININFO;



static PIXELFORMATDESCRIPTOR pfd =
    {
    sizeof(PIXELFORMATDESCRIPTOR),
    1,
    PFD_DRAW_TO_WINDOW|PFD_SUPPORT_OPENGL|PFD_DOUBLEBUFFER,
    PFD_TYPE_RGBA,
    32,
    0, 0, 0, 0, 0, 0, 8, 0,
    0, 0, 0, 0, 0,  // accum
    32,             // zbuffer
    0,              // stencil!
    0,              // aux
    PFD_MAIN_PLANE,
    0, 0, 0, 0
    };

static WININFO wininfo = {  0,0,0,0,0,
                            {'g','m','l',0}
                            };


static const int wavHeader[11] = {
    0x46464952,
    SU_BUFFER_LENGTH * 2 + 36,
    0x45564157,
    0x20746D66,
    16,
    WAVE_FORMAT_PCM | (SU_CHANNEL_COUNT << 16),
    SU_SAMPLE_RATE,
    SU_SAMPLE_RATE* SU_CHANNEL_COUNT * sizeof(short),
    (SU_CHANNEL_COUNT * sizeof(short)) | ((8 * sizeof(short)) << 16),
    0x61746164,
    SU_BUFFER_LENGTH * 2 * sizeof(short) };

static short myMuzik[SU_BUFFER_LENGTH * 2 + 22];

#define NUMFUNCIONES 15

static void *myglfunc[NUMFUNCIONES];

static const char *strs[] = {
    "glCreateShaderProgramv",
    "glUseProgram",
    "glGetProgramiv",
    "glGetProgramInfoLog",
    "glUniform1f",
    "glGenFramebuffers",
    "glBindFramebuffer",
    "glFramebufferTexture",
    "glDrawBuffers",
    "glCheckFramebufferStatus",
    "glUniform1i",
    "glGenRenderbuffers",
    "glBindRenderbuffer",
    "glRenderbufferStorage",
    "glFramebufferRenderbuffer"};

#define oglCreateShaderProgramv         ((PFNGLCREATESHADERPROGRAMVPROC)myglfunc[0])
#define oglUseProgram                   ((PFNGLUSEPROGRAMPROC)myglfunc[1])
#define oglGetProgramiv                 ((PFNGLGETPROGRAMIVPROC)myglfunc[2])
#define oglGetProgramInfoLog            ((PFNGLGETPROGRAMINFOLOGPROC)myglfunc[3])
#define oglUniform1f                    ((PFNGLUNIFORM1FPROC)myglfunc[4])
#define oglGenFramebuffers              ((PFNGLGENFRAMEBUFFERSPROC)myglfunc[5])
#define oglBindFramebuffer              ((PFNGLBINDFRAMEBUFFERPROC)myglfunc[6])
#define oglFramebufferTexture           ((PFNGLFRAMEBUFFERTEXTUREPROC)myglfunc[7])
#define oglDrawBuffers                  ((PFNGLDRAWBUFFERSPROC)myglfunc[8])
#define oglCheckFramebufferStatus       ((PFNGLCHECKFRAMEBUFFERSTATUSPROC)myglfunc[9])
#define oglUniform1i                    ((PFNGLUNIFORM1IPROC)myglfunc[10])
#define oglGenRenderbuffers             ((PFNGLGENRENDERBUFFERSPROC)myglfunc[11])
#define oglBindRenderbuffer             ((PFNGLBINDRENDERBUFFERPROC)myglfunc[12])
#define oglRenderbufferStorage          ((PFNGLRENDERBUFFERSTORAGEPROC)myglfunc[13])
#define oglFramebufferRenderbuffer      ((PFNGLFRAMEBUFFERRENDERBUFFERPROC)myglfunc[14])

//==============================================================================================


static LRESULT CALLBACK WndProc( HWND hWnd, UINT uMsg, WPARAM wParam, LPARAM lParam )
{
    // salvapantallas
    if( uMsg==WM_SYSCOMMAND && (wParam==SC_SCREENSAVE || wParam==SC_MONITORPOWER) )
        return( 0 );

    // boton x o pulsacion de escape
    if( uMsg==WM_CLOSE || uMsg==WM_DESTROY || (uMsg==WM_KEYDOWN && wParam==VK_ESCAPE) )
    {
        PostQuitMessage(0);
        return( 0 );
    }

    if( uMsg==WM_SIZE )
    {
        glViewport( 0, 0, lParam&65535, lParam>>16 );
    }

    if( uMsg==WM_CHAR || uMsg==WM_KEYDOWN)
    {
        if( wParam==VK_ESCAPE )
        {
            PostQuitMessage(0);
            return( 0 );
        }
    }

    return( DefWindowProc(hWnd,uMsg,wParam,lParam) );
}


static void window_end( WININFO *info )
{
    if( info->hRC )
    {
        wglMakeCurrent( 0, 0 );
        wglDeleteContext( info->hRC );
    }

    if( info->hDC  ) ReleaseDC( info->hWnd, info->hDC );
    if( info->hWnd ) DestroyWindow( info->hWnd );

    UnregisterClass( info->wndclass, info->hInstance );

    if( info->full )
    {
        ChangeDisplaySettings( 0, 0 );
        while( ShowCursor( 1 )<0 ); // show cursor
    }
}

static int window_init( WININFO *info )
{
    unsigned int    PixelFormat;
    DWORD           dwExStyle, dwStyle;
    DEVMODE         dmScreenSettings;
    RECT            rec;

    WNDCLASS        wc;

    ZeroMemory( &wc, sizeof(WNDCLASS) );
    wc.style         = CS_OWNDC|CS_HREDRAW|CS_VREDRAW;
    wc.lpfnWndProc   = WndProc;
    wc.hInstance     = info->hInstance;
    wc.lpszClassName = info->wndclass;
    wc.hbrBackground =(HBRUSH)CreateSolidBrush(0x00102030);
    
    if( !RegisterClass(&wc) )
        return( 0 );

    if( info->full )
    {
        dmScreenSettings.dmSize       = sizeof(DEVMODE);
        dmScreenSettings.dmFields     = DM_BITSPERPEL|DM_PELSWIDTH|DM_PELSHEIGHT;
        dmScreenSettings.dmBitsPerPel = 32;
        dmScreenSettings.dmPelsWidth  = XRES;
        dmScreenSettings.dmPelsHeight = YRES;

        if( ChangeDisplaySettings(&dmScreenSettings,CDS_FULLSCREEN)!=DISP_CHANGE_SUCCESSFUL)
            return( 0 );

        dwExStyle = WS_EX_APPWINDOW;
        dwStyle   = WS_VISIBLE | WS_POPUP;

        while( ShowCursor( 0 )>=0 );    // hide cursor
    }
    else
    {
        dwExStyle = 0;
        dwStyle   = WS_VISIBLE | WS_CAPTION | WS_SYSMENU | WS_MAXIMIZEBOX | WS_OVERLAPPED;
        dwStyle   = WS_VISIBLE | WS_OVERLAPPEDWINDOW|WS_POPUP;

    }

    rec.left   = 0;
    rec.top    = 0;
    rec.right  = XRES;
    rec.bottom = YRES;

    AdjustWindowRect( &rec, dwStyle, 0 );

    info->hWnd = CreateWindowEx( dwExStyle, wc.lpszClassName, "4k", dwStyle,
                               (GetSystemMetrics(SM_CXSCREEN)-rec.right+rec.left)>>1,
                               (GetSystemMetrics(SM_CYSCREEN)-rec.bottom+rec.top)>>1,
                               rec.right-rec.left, rec.bottom-rec.top, 0, 0, info->hInstance, 0 );

    if( !info->hWnd )
        return( 0 );

    if( !(info->hDC=GetDC(info->hWnd)) )
        return( 0 );

    if( !(PixelFormat=ChoosePixelFormat(info->hDC,&pfd)) )
        return( 0 );

    if( !SetPixelFormat(info->hDC,PixelFormat,&pfd) )
        return( 0 );

    if( !(info->hRC=wglCreateContext(info->hDC)) )
        return( 0 );

    if( !wglMakeCurrent(info->hDC,info->hRC) )
        return( 0 );

    return( 1 );
}


//==============================================================================================


int WINAPI WinMain( HINSTANCE instance, HINSTANCE hPrevInstance, LPSTR lpCmdLine, int nCmdShow )
{
    MSG         msg;
    int         done=0;
    WININFO     *info = &wininfo;

    SetProcessDpiAwarenessContext( DPI_AWARENESS_CONTEXT_SYSTEM_AWARE );

    info->hInstance = GetModuleHandle( 0 );
    //info->full++;

    //if( MessageBox( 0, "fullscreen?", info->wndclass, MB_YESNO|MB_ICONQUESTION)==IDYES ) info->full++;

    if( !window_init(info) )
    {
        window_end( info );
        MessageBox( 0, "window_init()!","error",MB_OK|MB_ICONEXCLAMATION );
        return( 0 );
    }

    char    error[1024];
    for( int i=0; i<NUMFUNCIONES; i++ )
    {
        myglfunc[i] = wglGetProcAddress( strs[i] );
        if( !myglfunc[i] ) 
        {
            memcpy(error, strs[i], strlen(strs[i]) + 1);
            MessageBox(info->hWnd, error, "Error GLProc", MB_OK);
            return( 0 );
        }
    }

    int fsId = oglCreateShaderProgramv(GL_FRAGMENT_SHADER, 1, &fragmentShader);                           
    int imgFsId = oglCreateShaderProgramv(GL_FRAGMENT_SHADER, 1, &imageShader);

    int     result;
    oglGetProgramiv( fsId, GL_LINK_STATUS, &result ); 
    if( result==0 )
    {
        oglGetProgramInfoLog( fsId, 1024, NULL, (char *)error );
        MessageBox(info->hWnd,error,"Error FS",MB_OK);
        return 0;
    }

    oglGetProgramiv(imgFsId, GL_LINK_STATUS, &result);
    if (result == 0)
    {
        oglGetProgramInfoLog(imgFsId, 1024, NULL, (char*)error);
        MessageBox(info->hWnd, error, "Error IMGFS", MB_OK);
        return 0;
    }

    // generate render target
    GLuint frameBufferId = 0;
    oglGenFramebuffers(1, &frameBufferId);
    oglBindFramebuffer(GL_FRAMEBUFFER, frameBufferId);

    // create texture with rgb output
    GLuint renderTexture;
    glGenTextures(1, &renderTexture);
    glBindTexture(GL_TEXTURE_2D, renderTexture);
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, XRES, YRES, 0, GL_RGB, GL_UNSIGNED_BYTE, 0);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP);

    // add depth buffer
    GLuint depthbuffer;
    oglGenRenderbuffers(1, &depthbuffer);
    oglBindRenderbuffer(GL_RENDERBUFFER, depthbuffer);
    oglRenderbufferStorage(GL_RENDERBUFFER, GL_DEPTH_COMPONENT, XRES, YRES);
    oglFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_DEPTH_ATTACHMENT, GL_RENDERBUFFER, depthbuffer);

    // configure framebuffer
    oglFramebufferTexture(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, renderTexture, 0);
    GLenum drawBuffers[1] = {GL_COLOR_ATTACHMENT0};
    oglDrawBuffers(1, drawBuffers);

    if (oglCheckFramebufferStatus(GL_FRAMEBUFFER) != GL_FRAMEBUFFER_COMPLETE)
    {
        window_end(info);
        MessageBox(0, "GL Framebuffer", "error", MB_OK | MB_ICONEXCLAMATION);
        return 0;
    }

    //su_render_song(myMuzik);
    memcpy(myMuzik + 22, myMuzik, SU_BUFFER_LENGTH);
    memcpy(myMuzik, wavHeader, 44);

    if (!sndPlaySound((const char*)&myMuzik, SND_ASYNC | SND_MEMORY))
    {
        window_end(info);
        MessageBox(0, "sndPlaySound", "error", MB_OK | MB_ICONEXCLAMATION);
        return 0;
    }

    long to = timeGetTime();
    float currentTime = 0.f;

    while (!done && currentTime < SU_LENGTH_IN_SAMPLES * 2 / SU_SAMPLE_RATE)
    {
        while( PeekMessage(&msg,0,0,0,PM_REMOVE) )
        {
            if( msg.message==WM_QUIT ) done=1;
            TranslateMessage( &msg );

            DispatchMessage( &msg );
        }
        currentTime = (float)(timeGetTime() - to) * 0.001f;

        // draw effect

        oglBindFramebuffer(GL_FRAMEBUFFER, frameBufferId);
        oglUseProgram(fsId);
        oglUniform1f(0, currentTime);
        glRects( -1, -1, 1, 1 );

        // draw post processing

        oglBindFramebuffer(GL_FRAMEBUFFER, 0);
        oglUseProgram(imgFsId);
        glBindTexture(GL_TEXTURE_2D, renderTexture);
        glRects(-1, -1, 1, 1);

        // flip buffer

        SwapBuffers( info->hDC );
        Sleep( 1 ); // give other processes some chance to do something
    }

    window_end( info );

    return( 0 );
}
