;-------------------------------------------------------------------------------
;   unit struct
;-------------------------------------------------------------------------------
struc su_unit
    .state      resd    8
    .ports      resd    8
    .size:
endstruc

;-------------------------------------------------------------------------------
;   voice struct
;-------------------------------------------------------------------------------
struc su_voice
    .note       resd    1
    .sustain    resd    1
    .inputs     resd    8
    .reserved   resd    6 ; this is done to so the whole voice is 2^n long, see polyphonic player
    .workspace  resb    63 * su_unit.size
    .size:
endstruc

;-------------------------------------------------------------------------------
;   synthworkspace struct
;-------------------------------------------------------------------------------
struc su_synthworkspace
    .curvoices  resb    32      ; these are used by the multitrack player to store which voice is playing on which track
    .left       resd    1
    .right      resd    1
    .aux        resd    6       ; 3 auxiliary signals
    .voices     resb    32 * su_voice.size
    .size:
endstruc

;-------------------------------------------------------------------------------
;   su_delayline_wrk struct
;-------------------------------------------------------------------------------
struc   su_delayline_wrk
    .dcin       resd    1
    .dcout      resd    1
    .filtstate  resd    1
    .buffer     resd    65536
    .size:
endstruc

;-------------------------------------------------------------------------------
;   su_sample_offset struct
;-------------------------------------------------------------------------------
struc   su_sample_offset  ; length conveniently 8 bytes, so easy to index
    .start      resd    1
    .loopstart  resw    1
    .looplength resw    1
    .size:
endstruc
;-------------------------------------------------------------------------------
;   Uninitialized data: The synth object
;-------------------------------------------------------------------------------
section .synth_object bss align=256
su_synth_obj:
    resb    su_synthworkspace.size
    resb    20*su_delayline_wrk.size


;-------------------------------------------------------------------------------
;   su_render_song function: the entry point for the synth
;-------------------------------------------------------------------------------
;   Has the signature su_render_song(void *ptr), where ptr is a pointer to
;   the output buffer. Renders the compile time hard-coded song to the buffer.
;   Stack:  output_ptr
;-------------------------------------------------------------------------------
section .su_render_song code align=1
global _su_render_song@4
_su_render_song@4:    
    pushad  ; Stack: edi, esi, ebp, esp, ebx, edx, ecx, eax, retaddr_su_render_song, OutputBufPtr
    xor     eax, eax
    push    1		; Stack: RandSeed, edi, esi, ebp, esp, ebx, edx, ecx, eax, retaddr_su_render_song, OutputBufPtr 
    push    eax		; Stack: GlobalTick, RandSeed, edi, esi, ebp, esp, ebx, edx, ecx, eax, retaddr_su_render_song, OutputBufPtr 
su_render_rowloop:                      ; loop through every row in the song
        push    eax		; Stack: Row, GlobalTick, RandSeed, edi, esi, ebp, esp, ebx, edx, ecx, eax, retaddr_su_render_song, OutputBufPtr 
        call    su_update_voices   ; update instruments for the new row
        xor     eax, eax                ; ecx is the current sample within row
su_render_sampleloop:                   ; loop through every sample in the row
            push    eax		; Stack: Sample, Row, GlobalTick, RandSeed, edi, esi, ebp, esp, ebx, edx, ecx, eax, retaddr_su_render_song, OutputBufPtr 
            push    9		; Stack: VoicesRemain, Sample, Row, GlobalTick, RandSeed, edi, esi, ebp, esp, ebx, edx, ecx, eax, retaddr_su_render_song, OutputBufPtr 
            mov     edx, dword su_synth_obj                       ; edx points to the synth object
            mov     ebx, dword su_patch_opcodes           ; COM points to vm code
            mov     esi, dword su_patch_operands             ; VAL points to unit params
            mov     ecx, dword su_synth_obj + su_synthworkspace.size - su_delayline_wrk.filtstate
            lea     ebp, [edx + su_synthworkspace.voices]            ; WRK points to the first voice
            call    su_run_vm ; run through the VM code
            pop     eax      ; eax = VoicesRemain, Stack: Sample, Row, GlobalTick, RandSeed, edi, esi, ebp, esp, ebx, edx, ecx, eax, retaddr_su_render_song, OutputBufPtr 
            mov     esi, [esp + 52] ; esi points to the output buffer
            mov     edi, dword su_synth_obj+su_synthworkspace.left
            mov     ecx, 2
            output_sound16bit_loop: ; loop over two channels, left & right
                    fld     dword [edi]
                    call    su_clip                
                    fmul    dword [FCONST_32767_0]
                    push    eax
                    fistp   dword [esp]
                    pop     eax
                    mov     word [esi],ax   ; // store integer converted right sample
                    xor     eax,eax
                    stosd
                    add     esi,2
                    loop    output_sound16bit_loop
            mov     [esp + 52], esi ; save esi back to stack                ; *ptr++ = left, *ptr++ = right
            pop     eax      ; eax = Sample, Stack: Row, GlobalTick, RandSeed, edi, esi, ebp, esp, ebx, edx, ecx, eax, retaddr_su_render_song, OutputBufPtr 
            inc     dword [esp + 4] ; increment global time, used by delays
            inc     eax
            cmp     eax, 2779
            jl      su_render_sampleloop
        pop     eax      ; eax = Row, Stack: GlobalTick, RandSeed, edi, esi, ebp, esp, ebx, edx, ecx, eax, retaddr_su_render_song, OutputBufPtr                   ; Stack: pushad ptr
        inc     eax
        cmp     eax, 1408
        jl      su_render_rowloop
    ; rewind the stack the entropy of multiple pop eax is probably lower than add
    pop     eax      ; eax = GlobalTick, Stack: RandSeed, edi, esi, ebp, esp, ebx, edx, ecx, eax, retaddr_su_render_song, OutputBufPtr 
    pop     eax      ; eax = RandSeed, Stack: edi, esi, ebp, esp, ebx, edx, ecx, eax, retaddr_su_render_song, OutputBufPtr     
    popad  ; Popped: eax, ecx, edx, ebx, esp, ebp, esi, edi. Stack: retaddr_su_render_song, OutputBufPtr
    ret     4

;-------------------------------------------------------------------------------
;   su_update_voices function: polyphonic & chord implementation
;-------------------------------------------------------------------------------
;   Input:      eax     :   current row within song
;   Dirty:      pretty much everything
;-------------------------------------------------------------------------------
section .su_update_voices code align=1
su_update_voices:
; The simple implementation: each track triggers always the same voice
    xor     edx, edx
    xor     ebx, ebx
    mov     bl, 32           ; rows per pattern
    div     ebx                                 ; eax = current pattern, edx = current row in pattern    
    lea     esi, [su_tracks+eax]; esi points to the pattern data for current track
    mov     edi, dword su_synth_obj+su_synthworkspace.voices
    mov     bl, 8                      ; MAX_TRACKS is always <= 32 so this is ok
su_update_voices_trackloop:
        movzx   eax, byte [esi]                     ; eax = current pattern
        imul    eax, 32           ; multiply by rows per pattern, eax = offset to current pattern data        
        movzx   eax, byte [su_patterns + eax + edx]  ; ecx = note
        cmp     al, 1                   ; anything but hold causes action
        je      short su_update_voices_nexttrack
        mov     dword [edi+su_voice.sustain], eax     ; set the voice currently active to release
        jb      su_update_voices_nexttrack          ; if cl < HLD (no new note triggered)  goto nexttrack
su_update_voices_retrigger:
        stosd                                       ; save note
        stosd                                       ; save sustain
        mov     ecx, (su_voice.size - su_voice.inputs)/4  ; could be xor ecx, ecx; mov ch,...>>8, but will it actually be smaller after compression?
        xor     eax, eax
        rep stosd                                   ; clear the workspace of the new voice, retriggering oscillators
        jmp     short su_update_voices_skipadd
su_update_voices_nexttrack:
        add     edi, su_voice.size
su_update_voices_skipadd:
        add     esi, 44
        dec     ebx
        jnz     short su_update_voices_trackloop
    ret

;-------------------------------------------------------------------------------
;   su_run_vm function: runs the entire virtual machine once, creating 1 sample
;-------------------------------------------------------------------------------
;   Input:      su_synth_obj.left   :   Set to 0 before calling
;               su_synth_obj.right  :   Set to 0 before calling
;               _CX                 :   Pointer to delay workspace (if needed)
;               _DX                 :   Pointer to synth object
;               COM                 :   Pointer to opcode stream
;               VAL                 :   Pointer to operand stream
;               WRK                 :   Pointer to the last workspace processed
;   Output:     su_synth_obj.left   :   left sample
;               su_synth_obj.right  :   right sample
;   Dirty:      everything
;-------------------------------------------------------------------------------
section .su_run_vm code align=1
su_run_vm:    
    pushad  ; Stack: edi, OperandStream, Voice, esp, OpcodeStream, Synth, DelayWorkSpace, eax, retaddr_su_run_vm, VoicesRemain, Sample, Row, GlobalTick, RandSeed, edi, esi, ebp, esp, ebx, edx, ecx, eax, retaddr_su_render_song, OutputBufPtr
su_run_vm_loop:                                     ; loop until all voices done
    movzx   edi, byte [ebx]                         ; edi = command byte
    inc     ebx                                     ; move to next instruction
    add     ebp, su_unit.size                       ; move WRK to next unit
    shr     edi, 1                                  ; shift out the LSB bit = stereo bit
    je      su_run_vm_advance                ; the opcode is zero, jump to advance
    mov     edx, [esp + 8]         ; reset INP to point to the inputs part of voice
    pushf                                          ; push flags to save carry = stereo bit
    add     edx, su_voice.inputs
    xor     ecx, ecx                                ; counter = 0
    xor     eax, eax                                ; clear out high bits of eax, as lodsb only sets al
su_transform_operands_loop:    
    cmp     cl, byte [su_vm_transformcounts-1+edi]   ; compare the counter to the value in the param count table
    je      su_transform_operands_out
    lodsb                                           ; load the operand from VAL stream
    push    eax                                     ; push it to memory so FPU can read it
    fild    dword [esp]                             ; load the operand value to FPU stack    
    fmul    dword [FCONST_0_00781250]          ; divide it by 128 (0 => 0, 128 => 1.0)
    fadd    dword [ebp+su_unit.ports+ecx*4]         ; add the modulations in the current workspace
    fstp    dword [edx+ecx*4]                       ; store the modulated value in the inputs section of voice
    xor     eax, eax
    mov     dword [ebp+su_unit.ports+ecx*4], eax    ; clear out the modulation ports
    pop     eax
    inc     ecx
    jmp     su_transform_operands_loop
su_transform_operands_out:
    popf                                          ; pop flags for the carry bit = stereo bit    
    call    [su_vm_jumptable-4+edi*4]       ; call the function corresponding to the instruction
    jmp     su_run_vm_loop
su_run_vm_advance:
    mov     ebp, dword [esp + 8] ; load pointer to voice to register
    add     ebp, su_voice.size              ; shift it to point to following voice
    mov     dword [esp + 8], ebp ; save back to stack
    dec     dword [esp + 36]  ; voices--
    jne     su_run_vm_loop                          ;   if there's more voices to process, goto vm_loop    
    popad  ; Popped: eax, ecx = DelayWorkSpace, edx = Synth, ebx = OpcodeStream, esp, ebp = Voice, esi = OperandStream, edi. Stack: retaddr_su_run_vm, VoicesRemain, Sample, Row, GlobalTick, RandSeed, edi, esi, ebp, esp, ebx, edx, ecx, eax, retaddr_su_render_song, OutputBufPtr
    ret
;-------------------------------------------------------------------------------
;   ADDP opcode: add the two top most signals on the stack and pop
;-------------------------------------------------------------------------------
;   Mono:   a b -> a+b
;   Stereo: a b c d -> a+c b+d
;-------------------------------------------------------------------------------
section .su_op_addp code align=1
su_op_addp:
    faddp   st1, st0
    ret

;-------------------------------------------------------------------------------
;   MULP opcode: multiply the two top most signals on the stack and pop
;-------------------------------------------------------------------------------
;   Mono:   a b -> a*b
;   Stereo: a b c d -> a*c b*d
;-------------------------------------------------------------------------------
section .su_op_mulp code align=1
su_op_mulp:
    fmulp   st1
    ret


;-------------------------------------------------------------------------------
;   HOLD opcode: sample and hold the signal, reducing sample rate
;-------------------------------------------------------------------------------
;   Mono version:   holds the signal at a rate defined by the freq parameter
;   Stereo version: holds both channels
;-------------------------------------------------------------------------------
section .su_op_hold code align=1
su_op_hold:
    fld     dword [edx]    ; f x
    fmul    st0, st0                        ; f^2 x
    fchs                                    ; -f^2 x
    fadd    dword [ebp]              ; p-f^2 x
    fst     dword [ebp]              ; p <- p-f^2
    fldz                                    ; 0 p x
    fucomip st1                             ; p x
    fstp    dword [esp-4]                   ; t=p, x
    jc      short su_op_hold_holding        ; if (0 < p) goto holding
    fld1                                    ; 1 x
    fadd    dword [esp-4]                   ; 1+t x
    fstp    dword [ebp]   ; x
    fst     dword [ebp+4] ; save holded value
    ret                                     ; x
su_op_hold_holding:
    fstp    st0                             ;
    fld     dword [ebp+4] ; x
    ret

;-------------------------------------------------------------------------------
;   CRUSH opcode: quantize the signal to finite number of levels
;-------------------------------------------------------------------------------
;   Mono:   x   ->  e*int(x/e)              where e=2**(-24*resolution)
;   Stereo: l r ->  e*int(l/e) e*int(r/e)
;-------------------------------------------------------------------------------
section .su_op_crush code align=1
su_op_crush:
    call    su_effects_stereohelper
    xor     eax, eax
    call    su_nonlinear_map
    fxch    st0, st1
    fdiv    st0, st1
    frndint
    fmulp   st1, st0
    ret

;-------------------------------------------------------------------------------
;   FILTER opcode: perform low/high/band-pass/notch etc. filtering on the signal
;-------------------------------------------------------------------------------
;   Mono:   x   ->  filtered(x)
;   Stereo: l r ->  filtered(l) filtered(r)
;-------------------------------------------------------------------------------
section .su_op_filter code align=1
su_op_filter:
    lodsb ; load the flags to al
    fld     dword [edx + 4] ; r x
    fld     dword [edx]; f r x
    fmul    st0, st0                        ; f2 x (square the input so we never get negative and also have a smoother behaviour in the lower frequencies)
    fst     dword [ebp+12]                   ; f2 r x
    fmul    dword [ebp+8]  ; f2*b r x
    fadd    dword [ebp]   ; f2*b+l r x
    fst     dword [ebp]   ; l'=f2*b+l r x
    fsubp   st2, st0                        ; r x-l'
    fmul    dword [ebp+8]  ; r*b x-l'
    fsubp   st1, st0                        ; x-l'-r*b
    fst     dword [ebp+4]  ; h'=x-l'-r*b
    fmul    dword [ebp+12]                   ; f2*h'
    fadd    dword [ebp+8]  ; f2*h'+b
    fstp    dword [ebp+8]  ; b'=f2*h'+b
    fldz                                    ; 0
    test    al, byte 0x40
    jz      short su_op_filter_skiplowpass
    fadd    dword [ebp]
su_op_filter_skiplowpass:
    test    al, byte 0x10
    jz      short su_op_filter_skiphighpass
    fadd    dword [ebp+4]
su_op_filter_skiphighpass:
    test    al, byte 0x08
    jz      short su_op_filter_skipnegbandpass
    fsub    dword [ebp+8]
su_op_filter_skipnegbandpass:
    ret
;-------------------------------------------------------------------------------
;   PAN opcode: pan the signal
;-------------------------------------------------------------------------------
;   Mono:   s   ->  s*(1-p) s*p
;   Stereo: l r ->  l*(1-p) r*p
;
;   where p is the panning in [0,1] range
;-------------------------------------------------------------------------------
section .su_op_pan code align=1
su_op_pan:
    fld     dword [edx]    ; p s
    fmul    st1                                 ; p*s s
    fsub    st1, st0                            ; p*s s-p*s
                                                ; Equal to
                                                ; s*p s*(1-p)
    fxch                                        ; s*(1-p) s*p SHOULD PROBABLY DELETE, WHY BOTHER
    ret

;-------------------------------------------------------------------------------
;   DELAY opcode: adds delay effect to the signal
;-------------------------------------------------------------------------------
;   Mono:   perform delay on ST0, using delaycount delaylines starting
;           at delayindex from the delaytable
;   Stereo: perform delay on ST1, using delaycount delaylines starting
;           at delayindex + delaycount from the delaytable (so the right delays
;           can be different)
;-------------------------------------------------------------------------------
section .su_op_delay code align=1
su_op_delay:
    lodsw                           ; al = delay index, ah = delay count    
    pushad  ; Stack: edi, DelayVal, ebp, esp, DelayCom, edx, ecx, eax, retaddr_su_op_delay, edi, OperandStream, Voice, esp, OpcodeStream, Synth, DelayWorkSpace, eax, retaddr_su_run_vm, VoicesRemain, Sample, Row, GlobalTick, RandSeed, edi, esi, ebp, esp, ebx, edx, ecx, eax, retaddr_su_render_song, OutputBufPtr
    movzx   ebx, al    
    lea     ebx,[su_delay_times + ebx*2]                  ; BX now points to the right position within delay time table
    movzx   esi, word [esp + 84]          ; notice that we load word, so we wrap at 65536
    mov     ecx, dword [esp + 60]   ; ebp is now the separate delay workspace, as they require a lot more space
    jnc     su_op_delay_mono
    push    eax                 ; save _ah (delay count)
    fxch                        ; r l
    call    su_op_delay_do      ; D(r) l        process delay for the right channel
    pop     eax                 ; restore the count for second run
    fxch                        ; l D(r)
su_op_delay_mono:               ; flow into mono delay
    call    su_op_delay_do      ; when stereo delay is not enabled, we could inline this to save 5 bytes, but I expect stereo delay to be farely popular so maybe not worth the hassle
    mov     dword [esp + 60],ecx   ; move delay workspace pointer back to stack.    
    popad  ; Popped: eax, ecx, edx, ebx = DelayCom, esp, ebp, esi = DelayVal, edi. Stack: retaddr_su_op_delay, edi, OperandStream, Voice, esp, OpcodeStream, Synth, DelayWorkSpace, eax, retaddr_su_run_vm, VoicesRemain, Sample, Row, GlobalTick, RandSeed, edi, esi, ebp, esp, ebx, edx, ecx, eax, retaddr_su_render_song, OutputBufPtr
    ret

;-------------------------------------------------------------------------------
;   su_op_delay_do: executes the actual delay
;-------------------------------------------------------------------------------
;   Pseudocode:
;   q = dr*x
;   for (i = 0;i < count;i++)
;     s = b[(t-delaytime[i+offset])&65535]
;     q += s
;     o[i] = o[i]*da+s*(1-da)
;     b[t] = f*o[i] +p^2*x
;  Perform dc-filtering q and output q
;-------------------------------------------------------------------------------
section .su_op_delay_do code align=1
su_op_delay_do:                         ; x y
    fld     st0
    fmul    dword [edx]  ; p*x y
    fmul    dword [edx]  ; p*p*x y
    fxch                                        ; y p*p*x
    fmul    dword [edx + 4]      ; dr*y p*p*x
su_op_delay_loop:
        mov     edi, esi
        sub     di, word [ebx]                      ; we perform the math in 16-bit to wrap around
        fld     dword [ecx+su_delayline_wrk.buffer+edi*4]; s dr*y p*p*x, where s is the sample from delay buffer
        fadd    st1, st0                                ; s dr*y+s p*p*x (add comb output to current output)
        fld1                                            ; 1 s dr*y+s p*p*x
        fsub    dword [edx + 12]         ; 1-da s dr*y+s p*p*x
        fmulp   st1, st0                                ; s*(1-da) dr*y+s p*p*x
        fld     dword [edx + 12]         ; da s*(1-da) dr*y+s p*p*x
        fmul    dword [ecx+su_delayline_wrk.filtstate]  ; o*da s*(1-da) dr*y+s p*p*x, where o is stored
        faddp   st1, st0                                ; o*da+s*(1-da) dr*y+s p*p*x    
        fadd    dword [FCONST_0_500000]           ; add and sub small offset to prevent denormalization. WARNING: this is highly important, as the damp filters might denormalize and give 100x CPU penalty
        fsub    dword [FCONST_0_500000]           ; See for example: https://stackoverflow.com/questions/36781881/why-denormalized-floats-are-so-much-slower-than-other-floats-from-hardware-arch
        fst     dword [ecx+su_delayline_wrk.filtstate]  ; o'=o*da+s*(1-da), o' dr*y+s p*p*x
        fmul    dword [edx + 8]     ; f*o' dr*y+s p*p*x
        fadd    st0, st2                                ; f*o'+p*p*x dr*y+s p*p*x
        fstp    dword [ecx+su_delayline_wrk.buffer+esi*4]; save f*o'+p*p*x to delay buffer
        add     ebx,2                                   ; move to next index
        add     ecx, su_delayline_wrk.size              ; go to next delay delay workspace
        sub     ah, 2
        jg      su_op_delay_loop                        ; if ah > 0, goto loop
    fstp    st1                                 ; dr*y+s1+s2+s3+...
    ; DC-filtering
    fld     dword [ecx+su_delayline_wrk.dcout]  ; o s    
    fmul    dword [FCONST_0_99609375]                ; c*o s
    fsub    dword [ecx+su_delayline_wrk.dcin]   ; c*o-i s
    fxch                                        ; s c*o-i
    fst     dword [ecx+su_delayline_wrk.dcin]   ; i'=s, s c*o-i
    faddp   st1                                 ; s+c*o-i    
    fadd    dword [FCONST_0_500000]          ; add and sub small offset to prevent denormalization. WARNING: this is highly important, as low pass filters might denormalize and give 100x CPU penalty
    fsub    dword [FCONST_0_500000]          ; See for example: https://stackoverflow.com/questions/36781881/why-denormalized-floats-are-so-much-slower-than-other-floats-from-hardware-arch
    fst     dword [ecx+su_delayline_wrk.dcout]  ; o'=s+c*o-i
    ret



;-------------------------------------------------------------------------------
;   OUT opcode: outputs and pops the signal
;-------------------------------------------------------------------------------
;   Stereo: add ST0 to left out and ST1 to right out, then pop
;-------------------------------------------------------------------------------
section .su_op_out code align=1
su_op_out:   ; l r
    mov     edi, [esp + 24] ; DI points to the synth object, use DI consistently in sinks/sources presumably to increase compression rate
    call    su_op_out_mono
    add     edi, 4 ; shift from left to right channel
su_op_out_mono:
    fmul    dword [edx] ; multiply by gain
    fadd    dword [edi + su_synthworkspace.left]   ; add current value of the output
    fstp    dword [edi + su_synthworkspace.left]   ; store the new value of the output
    ret

;-------------------------------------------------------------------------------
;   OUTAUX opcode: outputs to main and aux1 outputs and pops the signal
;-------------------------------------------------------------------------------
;   Mono: add outgain*ST0 to main left port and auxgain*ST0 to aux1 left
;   Stereo: also add outgain*ST1 to main right port and auxgain*ST1 to aux1 right
;-------------------------------------------------------------------------------
section .su_op_outaux code align=1
su_op_outaux: ; l r
    mov     edi, [esp + 24]
    call    su_op_outaux_mono
    add     edi, 4
su_op_outaux_mono:
    fld     st0                                     ; l l
    fmul    dword [edx]   ; g*l
    fadd    dword [edi + su_synthworkspace.left]             ; g*l+o
    fstp    dword [edi + su_synthworkspace.left]             ; o'=g*l+o
    fmul    dword [edx + 4]   ; h*l
    fadd    dword [edi + su_synthworkspace.aux]              ; h*l+a
    fstp    dword [edi + su_synthworkspace.aux]              ; a'=h*l+a
    ret

;-------------------------------------------------------------------------------
;   SEND opcode: adds the signal to a port
;-------------------------------------------------------------------------------
;   Mono: adds signal to a memory address, defined by a word in VAL stream
;   Stereo: also add right signal to the following address
;-------------------------------------------------------------------------------
section .su_op_send code align=1
su_op_send:
    lodsw
    mov     ecx, [esp + 12]  ; load pointer to voice
    pushf   ; uh ugly: we save the flags just for the stereo carry bit. Doing the .CX loading later crashed the synth for stereo sends as loading the synth address from stack was f'd up by the "call su_op_send_mono"
    test    ah, 0x80
    jz      su_op_send_skipglobal
    mov     ecx, [esp + 24 + 4]
su_op_send_skipglobal:
    popf
    test    al, 0x8             ; if the SEND_POP bit is not set
    jnz     su_op_send_skippush
    fld     st0                 ; duplicate the signal on stack: s s
su_op_send_skippush:            ; there is signal s, but maybe also another: s (s)
    fld     dword [edx]   ; a l (l)    
    fsub    dword [FCONST_0_500000]                    ; a-.5 l (l)
    fadd    st0                                ; g=2*a-1 l (l)
    and     ah, 0x7f ; eax = send address, clear the global bit
    or      al, 0x8 ; set the POP bit always, at the same time shifting to ports instead of wrk
    fmulp   st1, st0                           ; g*l (l)
    fadd    dword [ecx + eax*4]     ; g*l+L (l),where L is the current value
    fstp    dword [ecx + eax*4]     ; (l)
    ret

;-------------------------------------------------------------------------------
;   ENVELOPE opcode: pushes an ADSR envelope value on stack [0,1]
;-------------------------------------------------------------------------------
;   Mono:   push the envelope value on stack
;   Stereo: push the envelope valeu on stack twice
;-------------------------------------------------------------------------------
section .su_op_envelope code align=1
su_op_envelope:
    mov     eax, dword [edx-su_voice.inputs+su_voice.sustain] ; eax = su_instrument.sustain
    test    eax, eax                            ; if (eax != 0)
    jne     su_op_envelope_process              ;   goto process
    mov     al, 3  ; [state]=RELEASE
    mov     dword [ebp], eax               ; note that mov al, XXX; mov ..., eax is less bytes than doing it directly
su_op_envelope_process:
    mov     eax, dword [ebp]  ; al=[state]
    fld     dword [ebp+4]       ; x=[level]
    cmp     al, 2               ; if (al==SUSTAIN)
    je      short su_op_envelope_leave2         ;   goto leave2
su_op_envelope_attac:
    cmp     al, 0                 ; if (al!=ATTAC)
    jne     short su_op_envelope_decay          ;   goto decay
    call    su_nonlinear_map                ; a x, where a=attack
    faddp   st1, st0                            ; a+x
    fld1                                        ; 1 a+x
    fucomi  st1                                 ; if (a+x<=1) // is attack complete?
    fcmovnb st0, st1                            ;   a+x a+x
    jbe     short su_op_envelope_statechange    ; else goto statechange
su_op_envelope_decay:
    cmp     al, 1                 ; if (al!=DECAY)
    jne     short su_op_envelope_release        ;   goto release
    call    su_nonlinear_map                ; d x, where d=decay
    fsubp   st1, st0                            ; x-d
    fld     dword [edx + 8]    ; s x-d, where s=sustain
    fucomi  st1                                 ; if (x-d>s) // is decay complete?
    fcmovb  st0, st1                            ;   x-d x-d
    jnc     short su_op_envelope_statechange    ; else goto statechange
su_op_envelope_release:
    cmp     al, 3               ; if (al!=RELEASE)
    jne     short su_op_envelope_leave          ;   goto leave
    call    su_nonlinear_map                ; r x, where r=release
    fsubp   st1, st0                            ; x-r
    fldz                                        ; 0 x-r
    fucomi  st1                                 ; if (x-r>0) // is release complete?
    fcmovb  st0, st1                            ;   x-r x-r, then goto leave
    jc      short su_op_envelope_leave
su_op_envelope_statechange:
    inc     dword [ebp]       ; [state]++
su_op_envelope_leave:
    fstp    st1                                 ; x', where x' is the new value
    fst     dword [ebp+4]       ; [level]=x'
su_op_envelope_leave2:
    fmul    dword [edx + 16]       ; [gain]*x'
    ret

;-------------------------------------------------------------------------------
;   NOISE opcode: creates noise
;-------------------------------------------------------------------------------
;   Mono:   push a random value [-1,1] value on stack
;   Stereo: push two (differeent) random values on stack
;-------------------------------------------------------------------------------
section .su_op_noise code align=1
su_op_noise:
    lea     ecx,[esp + 56]
    imul    eax, [ecx],16007
    mov     [ecx],eax
    fild    dword [ecx]
    fidiv   dword [ICONST_2147483648] ; 65536*32768
    fld     dword [edx]
    call    su_waveshaper
    fmul    dword [edx + 4]
    ret

;-------------------------------------------------------------------------------
;   OSCILLAT opcode: oscillator, the heart of the synth
;-------------------------------------------------------------------------------
;   Mono:   push oscillator value on stack
;   Stereo: push l r on stack, where l has opposite detune compared to r
;-------------------------------------------------------------------------------
section .su_op_oscillator code align=1
su_op_oscillator:
    lodsb                                   ; load the flags
    fld     dword [edx + 4] ; e, where e is the detune [0,1]
    fsub    dword [FCONST_0_500000]                 ; e-.5
    fadd    st0, st0                        ; d=2*e-.5, where d is the detune [-1,1]
    fld     dword [edx]
    fsub    dword [FCONST_0_500000]
    fdiv    dword [FCONST_0_00781250]
    faddp   st1
    test    al, byte 0x08
    jnz     su_op_oscillat_skipnote
    fiadd   dword [edx-su_voice.inputs+su_voice.note]   ; // st0 is note, st1 is t+d offset
su_op_oscillat_skipnote:
    fmul    dword [ICONST_1034594986]
    call    su_power
    test    al, byte 0x08
    jz      short su_op_oscillat_normalize_note
    fmul    dword [FCONST_3_80000em05]  ; // st0 is now frequency for lfo
    jmp     short su_op_oscillat_normalized
su_op_oscillat_normalize_note:
    fmul    dword [FCONST_9_269614em05]   ; // st0 is now frequency
su_op_oscillat_normalized:
    fadd    dword [ebp]
    fld1                     ; we need to take mod(p,1) so the frequency does not drift as the float
    fadd    st1, st0         ; make no mistake: without this, there is audible drifts in oscillator pitch
    fxch                     ; as the actual period changes once the phase becomes too big
    fprem                    ; we actually computed mod(p+1,1) instead of mod(p,1) as the fprem takes mod
    fstp    st1              ; towards zero
    fst     dword [ebp] ; store back the updated phase
    fadd    dword [edx + 8]
    fld1                    ; this is a bit stupid, but we need to take mod(x,1) again after phase modulations
    fadd    st1, st0        ; as the actual oscillator functions expect x in [0,1]
    fxch
    fprem
    fstp    st1
    fld     dword [edx + 12]               ; // c      p
    ; every oscillator test included if needed
    test    al, byte 0x40
    jz      short su_op_oscillat_notsine
    call    su_oscillat_sine
su_op_oscillat_notsine:
    test    al, byte 0x20
    jz      short su_op_oscillat_not_trisaw
    call    su_oscillat_trisaw
su_op_oscillat_not_trisaw:
    test    al, byte 0x10
    jz      short su_op_oscillat_not_pulse
    call    su_oscillat_pulse
su_op_oscillat_not_pulse:
su_op_oscillat_shaping:
    ; finally, shape the oscillator and apply gain
    fld     dword [edx + 16]
    call    su_waveshaper
su_op_oscillat_gain:
    fmul    dword [edx + 20]
    ret

section .su_oscillat_pulse code align=1
su_oscillat_pulse:
    fucomi  st1                             ; // c      p
    fld1
    jnc     short su_oscillat_pulse_up      ; // +1     c       p
    fchs                                    ; // -1     c       p
su_oscillat_pulse_up:
    fstp    st1                             ; // +-1    p
    fstp    st1                             ; // +-1
    ret

section .su_oscillat_trisaw code align=1
su_oscillat_trisaw:
    fucomi  st1                             ; // c      p
    jnc     short su_oscillat_trisaw_up
    fld1                                    ; // 1      c       p
    fsubr   st2, st0                        ; // 1      c       1-p
    fsubrp  st1, st0                        ; // 1-c    1-p
su_oscillat_trisaw_up:
    fdivp   st1, st0                        ; // tp'/tc
    fadd    st0                             ; // 2*''
    fld1                                    ; // 1      2*''
    fsubp   st1, st0                        ; // 2*''-1
    ret

section .su_oscillat_sine code align=1
su_oscillat_sine:
    fucomi  st1                             ; // c      p
    jnc     short su_oscillat_sine_do
    fstp    st1
    fsub    st0, st0                        ; // 0
    ret
su_oscillat_sine_do:
    fdivp   st1, st0                        ; // p/c
    fldpi                                   ; // pi     p
    fadd    st0                             ; // 2*pi   p
    fmulp   st1, st0                        ; // 2*pi*p
    fsin                                    ; // sin(2*pi*p)
    ret

;-------------------------------------------------------------------------------
;   IN opcode: inputs and clears a global port
;-------------------------------------------------------------------------------
;   Mono: push the left channel of a global port (out or aux)
;   Stereo: also push the right channel (stack in l r order)
;-------------------------------------------------------------------------------
section .su_op_in code align=1
su_op_in:
    lodsb
    mov     edi, [esp + 24]
    xor     ecx, ecx ; we cannot xor before jnc, so we have to do it mono & stereo. LAHF / SAHF could do it, but is the same number of bytes with more entropy
    fld     dword [edi + su_synthworkspace.right + eax*4]
    mov     dword [edi + su_synthworkspace.right + eax*4], ecx
    fld     dword [edi + su_synthworkspace.left + eax*4]
    mov     dword [edi + su_synthworkspace.left + eax*4], ecx
    ret



;-------------------------------------------------------------------------------
;   su_nonlinear_map function: returns 2^(-24*x) of parameter number _AX
;-------------------------------------------------------------------------------
;   Input:      _AX     :   parameter number (e.g. for envelope: 0 = attac, 1 = decay...)
;               INP     :   pointer to transformed operands
;   Output:     st0     :   2^(-24*x), where x is the parameter in the range 0-1
;-------------------------------------------------------------------------------
section .su_nonlinear_map code align=1
su_nonlinear_map:
    fld     dword [edx+eax*4]   ; x, where x is the parameter in the range 0-1
    
    fimul   dword [ICONST_24]      ; 24*x
    fchs                        ; -24*x


;-------------------------------------------------------------------------------
;   su_power function: computes 2^x
;-------------------------------------------------------------------------------
;   Input:      st0     :   x
;   Output:     st0     :   2^x
;-------------------------------------------------------------------------------
global _su_pow@0
_su_pow@0:
su_power:
    fld1          ; 1 x
    fld st1       ; x 1 x
    fprem         ; mod(x,1) 1 x
    f2xm1         ; 2^mod(x,1)-1 1 x
    faddp st1,st0 ; 2^mod(x,1) x
    fscale        ; 2^mod(x,1)*2^trunc(x) x
                  ; Equal to:
                  ; 2^x x
    fstp st1      ; 2^x
    ret


;-------------------------------------------------------------------------------
;   DISTORT opcode: apply distortion on the signal
;-------------------------------------------------------------------------------
;   Mono:   x   ->  x*a/(1-a+(2*a-1)*abs(x))            where x is clamped first
;   Stereo: l r ->  l*a/(1-a+(2*a-1)*abs(l)) r*a/(1-a+(2*a-1)*abs(r))
;   This is placed here to be able to flow into waveshaper & also include
;   wave shaper if needed by some other function; need to investigate the
;   best way to do this
;-------------------------------------------------------------------------------
section .su_op_distort code align=1
su_op_distort:
    fld     dword [edx]

su_waveshaper:
    fld     st0                             ; a a x
    
    fsub    dword [FCONST_0_500000]                 ; a-.5 a x
    fadd    st0                             ; 2*a-1 a x
    fld     st2                             ; x 2*a-1 a x
    fabs                                    ; abs(x) 2*a-1 a x
    fmulp   st1                             ; (2*a-1)*abs(x) a x
    fld1                                    ; 1 (2*a-1)*abs(x) a x
    faddp   st1                             ; 1+(2*a-1)*abs(x) a x
    fsub    st1                             ; 1-a+(2*a-1)*abs(x) a x
    fdivp   st1, st0                        ; a/(1-a+(2*a-1)*abs(x)) x
    fmulp   st1                             ; x*a/(1-a+(2*a-1)*abs(x))
    ret

;-------------------------------------------------------------------------------
;   su_effects_stereohelper: moves the workspace to next, does the filtering for
;   right channel (pulling the calling address from stack), rewinds the
;   workspace and returns
;-------------------------------------------------------------------------------
section .su_effects_stereohelper code align=1
su_effects_stereohelper:
    jnc     su_effects_stereohelper_mono ; carry is still the stereo bit
    add     ebp, 16
    fxch                  ; r l
    call    [esp]         ; call whoever called me...
    fxch                  ; l r
    sub     ebp, 16       ; move WRK back to where it was
su_effects_stereohelper_mono:
    ret                   ; return to process l/mono sound


section .su_clip code align=1
su_clip:
    fld1                                    ; 1 x a
    fucomi  st1                             ; if (1 <= x)
    jbe     short su_clip_do                ;   goto Clip_Do
    fchs                                    ; -1 x a
    fucomi  st1                             ; if (-1 < x)
    fcmovb  st0, st1                        ;   x x a
su_clip_do:
    fstp    st1                             ; x' a, where x' = clamp(x)
    ret


;-------------------------------------------------------------------------------
; The opcode table jump table. This is constructed to only include the opcodes
; that are used so that the jump table is as small as possible.
;-------------------------------------------------------------------------------
section .su_vm_jumptable data align=1
su_vm_jumptable:
    dd    su_op_envelope
    dd    su_op_oscillator
    dd    su_op_send
    dd    su_op_mulp
    dd    su_op_filter
    dd    su_op_pan
    dd    su_op_outaux
    dd    su_op_noise
    dd    su_op_addp
    dd    su_op_delay
    dd    su_op_distort
    dd    su_op_hold
    dd    su_op_crush
    dd    su_op_in
    dd    su_op_out

;-------------------------------------------------------------------------------
; The number of transformed parameters each opcode takes
;-------------------------------------------------------------------------------
section .su_vm_transformcounts data align=1
su_vm_transformcounts:
    db    5
    db    6
    db    1
    db    0
    db    2
    db    1
    db    2
    db    2
    db    0
    db    4
    db    1
    db    1
    db    1
    db    0
    db    1


;-------------------------------------------------------------------------------
;    Patterns
;-------------------------------------------------------------------------------
section .su_patterns data align=1
su_patterns:
    db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    db 48,0,0,0,59,0,60,0,48,0,0,0,46,1,0,0,48,0,0,0,59,0,60,0,48,0,0,0,46,1,0,0
    db 46,0,0,0,57,0,58,0,46,0,0,0,57,1,1,0,45,0,0,0,56,0,57,0,44,0,0,0,42,0,0,0
    db 43,0,0,0,54,0,55,0,43,0,0,0,41,1,1,0,43,0,0,0,54,0,55,0,43,0,0,0,41,1,1,0
    db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,55,0,55,0,53,0,53,0,52,0,50,50,48,0,45,0
    db 74,1,1,1,67,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    db 79,1,1,1,72,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,43,0,43,0,43,0,55,0,0,0,45,0,43,1,0,0
    db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,48,0,48,0,48,0,60,0,0,0,50,0,48,1,0,0
    db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,67,0,79,0,74,0,0,0,0,0,0,0,0,0,0,0
    db 0,0,55,0,55,0,43,1,1,1,43,1,1,1,1,1,55,0,67,1,1,1,55,0,0,0,0,0,67,0,0,0
    db 0,0,60,0,60,0,48,1,1,1,48,1,1,1,1,1,60,0,72,1,1,1,60,0,0,0,0,0,72,0,0,0
    db 84,1,72,1,60,1,82,1,1,1,81,1,69,1,1,1,80,1,68,1,56,1,1,1,68,1,56,1,55,1,1,0
    db 41,1,1,1,53,1,0,0,0,0,0,0,43,1,0,0,0,0,0,0,55,1,43,1,1,1,1,1,1,1,1,1
    db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
    db 1,1,55,1,1,1,1,1,55,1,0,0,0,0,43,1,0,0,67,1,1,1,1,1,43,1,1,1,60,1,55,1
    db 1,1,1,1,1,1,1,1,55,1,0,0,0,0,67,1,0,0,45,1,1,1,1,1,55,1,1,1,1,1,1,1
    db 1,1,55,1,1,1,1,1,55,1,0,0,0,0,55,1,0,0,67,1,1,1,1,1,43,1,1,1,55,1,43,1
    db 38,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
    db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0

;-------------------------------------------------------------------------------
;    Tracks
;-------------------------------------------------------------------------------
section .su_tracks data align=1
su_tracks:
    db 3,3,3,3,3,3,3,3,1,1,1,2,3,3,3,3,3,3,3,3,1,1,1,2,3,3,3,3,3,3,3,0,3,3,3,3,1,1,1,2,3,3,3,3
    db 4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,0,4,4,4,4,4,4,4,4,4,4,4,4
    db 5,0,0,0,5,0,0,0,6,0,0,0,5,0,0,0,5,0,0,0,6,0,0,0,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5,0,0,0
    db 7,0,0,0,7,0,0,0,8,0,0,0,7,0,0,0,7,0,0,0,8,0,0,0,7,0,0,0,7,7,7,7,0,0,0,0,8,0,0,0,7,0,7,0
    db 0,0,0,0,0,0,0,9,0,0,0,9,0,0,0,0,0,0,0,9,0,0,0,9,0,0,0,0,0,0,0,0,10,10,10,10,11,11,11,12,10,10,10,9
    db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,13,13,13,13,13,13,13,13,13,13,13,13,13,13,13,14,13,13,13,13,13,13,13,13,13,13,13,13
    db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,15,15,16,17,16,15,16,17,16,15,16,17,16,15,16,17,16,15,16,17,16,15,16,17,16,15,16,17,16,15
    db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,18,14,14,19,0,0,0,0,0,0,0,0,0,0,0,0
;-------------------------------------------------------------------------------
;    Delay times
;-------------------------------------------------------------------------------
section .su_delay_times data align=1
su_delay_times:
    dw 33352,7411,16676,512,1116,1188,1276,1356,1422,1492,1556,1618,1140,1212,1300,1380,1446,1516,1580,1642


;-------------------------------------------------------------------------------
;    The code for this patch, basically indices to vm jump table
;-------------------------------------------------------------------------------
section .su_patch_opcodes data align=1
su_patch_opcodes:
    db 2,4,6,4,8,10,12,15,0,2,16,8,10,12,15,0,2,4,6,4,6,6,6,4,10,4,10,4,10,18,18,2,6,10,8,20,12,15,0,2,4,4,18,22,10,10,22,24,8,20,12,15,0,2,2,6,6,4,18,6,4,6,4,4,4,18,18,10,10,8,20,12,20,15,0,2,6,2,22,24,6,4,8,10,26,12,15,0,2,6,2,6,6,4,4,16,10,18,18,8,10,12,27,15,0,2,16,2,6,10,8,12,15,0,29,21,31,0

;-------------------------------------------------------------------------------
;    The parameters / inputs to each opcode
;-------------------------------------------------------------------------------
section .su_patch_operands data align=1
su_patch_operands:
    db 0,96,0,64,128,64,73,0,128,64,128,64,96,74,0,64,64,64,128,64,128,64,70,68,64,64,96,4,0,64,0,0,128,64,128,99,128,16,64,60,0,0,64,88,48,128,16,64,0,128,64,128,72,48,152,0,8,64,0,128,64,128,72,32,176,0,68,161,0,88,216,0,68,64,0,16,64,72,32,64,128,64,71,64,0,16,64,64,32,64,128,64,64,64,0,16,64,96,32,64,128,64,88,88,96,96,128,88,40,1,32,16,80,48,96,48,128,0,1,64,118,96,26,64,64,9,128,64,44,0,0,64,128,32,64,74,0,32,64,128,32,112,53,31,64,50,32,16,68,66,64,128,64,64,1,1,64,10,48,0,70,0,70,128,0,80,0,80,128,96,32,137,96,0,1,72,64,0,128,64,128,72,32,235,140,96,64,0,128,64,128,72,80,249,136,76,64,0,128,64,128,16,64,64,0,64,64,128,16,76,64,0,0,64,128,32,64,96,64,64,96,64,64,128,64,32,2,1,64,128,0,0,0,3,1,20,32,0,64,96,64,128,128,36,148,0,49,0,0,128,90,128,80,120,0,44,64,0,64,64,128,32,13,128,24,59,64,46,0,0,72,0,72,128,128,36,152,0,56,0,0,128,108,96,0,72,120,0,32,64,0,128,32,64,64,64,64,0,128,80,64,64,64,64,91,128,64,22,32,16,64,5,24,1,84,68,64,97,64,73,82,98,95,65,64,47,128,88,0,40,44,64,64,35,100,2,45,99,125,51,4,15,128

;-------------------------------------------------------------------------------
;    Constants
;-------------------------------------------------------------------------------
section .constants data align=1
FCONST_32767_0          dd 0x46fffe00
FCONST_0_00781250       dd 0x3c000000
FCONST_0_500000         dd 0x3f000000
FCONST_0_99609375       dd 0x3f7f0000
FCONST_3_80000em05      dd 0x381f6230
FCONST_9_269614em05     dd 0x38c265dc
ICONST_2147483648       dd 0x80000000
ICONST_1034594986       dd 0x3daaaaaa
ICONST_24               dd 0x18

