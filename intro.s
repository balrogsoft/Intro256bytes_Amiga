; 256 bytes intro skeleton for Amiga 500 with KS 1.3
; with 140 bytes free for your effect
; by Balrog Soft / Amiga Skool

    incdir  "Dh0:PhxAss/include/"
	
    include "graphics/graphics_lib.i"
    include "graphics/gfxbase.i"
    include "intuition/screens.i"

    move.w  #32,$dff096				; Disable mouse pointer

    move.l  $170(a2),a6            	; IntuitionBase from globvec
    move.l  ib_ActiveScreen(a6),a5	; a5 = ActiveScreen (640x256 on most systems)

    move.l  $4.w,a6					; ExecBase
    move.l  156(a6),a6				; graphics.library

    move.l  gb_ActiView(a6),a2		; Get ActiveView

    move.l  v_ViewPort(a2),a2		; Get ViewPort

    move.l  vp_RasInfo(a2),a2		; Get RasInfo
    move.l  ri_BitMap(a2),a2		; Get screen Bitmap

    ;lea     sc_ViewPort(a5),a0		; Set colors
    ;lea     palette(pc),a1
    ;moveq   #4,d0
    ;jsr     _LVOLoadRGB4(a6)
	
frameloop:
    move.l  #255,d7               ; y

palette:
    move.l  bm_Planes(a2),a3		; Bitplane 0 to a3
    move.l  bm_Planes+4(a2),a4		; Bitplane 1 to a4

yLoop:
    move.w	#19,d6                 ; x
	
xLoop:
	; write data to bitplanes
	;move.l  #$00ff00ff,(a3)+
    ;move.l  #$0ff00ff0,(a4)+
	
    dbra	d6,xLoop
	
    dbra	d7,yLoop
	
	btst	#6,$bfe001				; Check for mouse left click button to exit
    bne.s	frameloop
	moveq	#0,d0
    rts
