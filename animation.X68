*-----------------------------------------------------------
* Title      : Rectangle Animation
* Written by : Trevor Trusty
* Date       : 7/19/2020
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program
    ** SET DRAWING PROPERTIES
    move.l  #$00FFFFFF,D1 ; pen color choice (white)
    move    #80,D0         ; set trap
    trap    #15            ; set pen color
    
    move.l  #$000000FF,D1 ; fill color choice (red)
    move #81,D0
    trap #15


    *initialize rectangle pos
    move.w #50, D1 ; x1
    move.w #120, D3 ; x2
    move.w #50, D2 ; y1
    move.w #120, D4 ; y2
    
    *begin animation
    jmp loop_right
    
    SIMHALT             ; halt simulator

********************************
** Loop routines, animate square
********************************
loop_right:
    jsr draw_rect
    jsr move_right
    cmp #500,D1
    BGE loop_left
    jmp loop_right
    
loop_left:
    jsr draw_rect
    jsr move_left
    cmp #50,D1
    BLE loop_right
    jmp loop_left
********************************


draw_rect:    
    jsr cls
    move    #87,D0         ; filled rect trap
    trap    #15     ; draw rectangle
    jsr delay
    rts
    
move_right:
    add #20,D1
    add #20,D3
    rts
    
move_left:
    sub #20,D1
    sub #20,D3
    rts

delay:
    move #23,D0
    
    **backup D1**
    move D1,D7
    
    **execute delay trap**
    move.l #2,D1 ; set time in 1/100 second
    trap #15
    
    **restore D1**
    move.l D7,D1    
    rts

cls:
    move #11,D0
    move D1,D6 ; temp backup D1
    move.w #$FF00,D1 
    trap #15
    move D6,D1 ; restore D1
    rts
   
    END    START        ; last line of source






*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
