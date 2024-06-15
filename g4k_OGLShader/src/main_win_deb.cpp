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
                            {'i','q','_',0}
                            };

#define NUMFUNCIONES 5

static void *myglfunc[NUMFUNCIONES];

static const char *strs[] = {
    "glCreateShaderProgramv",
    "glUseProgram",
    "glGetProgramiv",
    "glGetProgramInfoLog",
    "glUniform1f", };

#define oglCreateShaderProgramv         ((PFNGLCREATESHADERPROGRAMVPROC)myglfunc[0])
#define oglUseProgram                   ((PFNGLUSEPROGRAMPROC)myglfunc[1])
#define oglGetProgramiv                 ((PFNGLGETPROGRAMIVPROC)myglfunc[2])
#define oglGetProgramInfoLog            ((PFNGLGETPROGRAMINFOLOGPROC)myglfunc[3])
#define oglUniform1f                    ((PFNGLUNIFORM1FPROC)myglfunc[4])

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

    //if( MessageBox( 0, "fullscreen?", info->wndclass, MB_YESNO|MB_ICONQUESTION)==IDYES ) info->full++;

    if( !window_init(info) )
    {
        window_end( info );
        MessageBox( 0, "window_init()!","error",MB_OK|MB_ICONEXCLAMATION );
        return( 0 );
    }

    for( int i=0; i<NUMFUNCIONES; i++ )
    {
        myglfunc[i] = wglGetProcAddress( strs[i] );
        if( !myglfunc[i] ) return( 0 );
    }

    int fsId = oglCreateShaderProgramv(GL_FRAGMENT_SHADER, 1, &fragmentShader);                           

    int     result;
    char    error[1024];
    oglGetProgramiv( fsId, GL_LINK_STATUS, &result ); 
    if( result==0 )
    {
        oglGetProgramInfoLog( fsId, 1024, NULL, (char *)error );
        MessageBox(info->hWnd,error,"Error",MB_OK);
        return 0;
    }


    oglUseProgram( fsId );

    float currentTime = 0.f;
    while( !done )
    {
        while( PeekMessage(&msg,0,0,0,PM_REMOVE) )
        {
            if( msg.message==WM_QUIT ) done=1;
            TranslateMessage( &msg );

            DispatchMessage( &msg );
        }
        currentTime += 0.02f;

        oglUniform1f(0, currentTime);

        glRects( -1, -1, 1, 1 );
        SwapBuffers( info->hDC );
        Sleep( 1 ); // give other processes some chance to do something
    }

    window_end( info );

    return( 0 );
}
