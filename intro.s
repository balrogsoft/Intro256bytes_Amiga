; 256 bytes intro skeleton for Amiga 500 with KS 1.3
; with 160 bytes free for your effect
; by Balrog Soft / Amiga Skool

ib_ActiveScreen	EQU 56
rp_BitMap		EQU 88
bm_Planes		EQU 8

	move.w  #32,$dff096             ; Disable mouse pointer (DMACON)

    move.l  $170(a2),a6             ; a6 = IntuitionBase from globvec
    move.l  ib_ActiveScreen(a6),a0  ; a0 = ib_ActiveScreen
    move.l  rp_BitMap(a0),a0        ; a0 = rp_BitMap
	
frameloop:
    move.w  #255,d7               	; y

    move.l  bm_Planes(a0),a3        ; Bitplane 0 to a3
    move.l  bm_Planes+4(a0),a4      ; Bitplane 1 to a4

yLoop:
    moveq   #19,d6                  ; x
    
xLoop:
    ; write data to bitplanes
    ;move.l  #$00ff00ff,(a3)+
    ;move.l  #$0ff00ff0,(a4)+
    
    dbra    d6,xLoop
    
    dbra    d7,yLoop
    
    btst    #6,$bfe001              ; Check for mouse left click button to exit
    bne.s   frameloop
    moveq   #0,d0
    rts
