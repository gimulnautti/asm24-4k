//--------------------------------------------------------------------------//
// iq / rgba  .  tiny codes  .  2008/2021                                   //
//--------------------------------------------------------------------------//

static const char *fragmentShader = \

"void main(void)"
"{"
    "float aa = gl_TexCoord[0].x;"

    "vec2 c=vec2(-0.75,0)+(2.0*gl_FragCoord.xy-vec2(1920,1080))/1080.0;"
    "c += 0.04*sin(aa+vec2(0,1.57))*sqrt(aa/32.0);"

    "vec2 z=vec2(0.0);"
    "float h=0.0;"
    "float m;"
    "for(int i=0;i<100;i++)"
    "{"
        "z=vec2(z.x*z.x-z.y*z.y,2.0*z.x*z.y)+c;"
        "m=dot(z,z);"
        "if(m>100000.0) break;"
        "h+=1.0;"
    "}"
    "h=h+1.0-log2(.5*log(m));"
    "gl_FragColor=vec4(h/100.0);"
"}";