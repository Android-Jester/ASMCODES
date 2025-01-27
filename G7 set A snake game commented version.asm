;Define registers 
;R0-2 reserved for temporary uses 
;Global variables: 
;R3 Tail position 
;R4 Head position 
;Constants:

DEFINEREGISTERS:
    MOV     R10,#.PixelScreen 
    MOV     R11, #.green //Colour of Snake
    MOV     R8, #0 //Score of apples eaten
    MOV     R12, #.red //Colour of apple

;Set up interrupts
    MOV     R0, #update 
    STR     R0, .ClockISR 
    MOV     R0, #0x50 
    STR     R0,.ClockInterruptFrequency
    MOV     R0, #keyPress 
    STR     R0, .KeyboardISR 
    MOV     R0, #1 
    STR     R0, .KeyboardMask

;Initialise game
INITIALISEGAME:
    MOV     R3,#1084 //Initialise tail
    MOV     R4,#1088 //Head next to it (4 bytes = 1 word = 1 pixel)
    STR     R11,[R10+R3]//Draw 2-segment snake
    STR     R11,[R10+R4]
    MOV     R5, #body  
    ADD     R6,R5,#4
    STR     R3, [R5] //R3 points to the tail address
    STR     R4, [R6] //R4 points to the head address
    MOV     R0, #1 
    BL      createApple
    STR     R0, .InterruptRegister 

mainLoop: b mainLoop ;Just keeps the processor running

;Called by keyboard interrupt 
;If valid key (W,A,S,D) has been pressed
keyPress: PUSH {R0} 
LDR     R0,.LastKey  ;Read the last key pressed (but don't wait for one)
CMP     R0,#87 ;W key
BEQ     updateLastKey 
CMP     R0,#65 ;a key
BEQ     updateLastKey 
CMP     R0,#83  ;S key
BEQ     updateLastKey 
CMP     R0,#68 ;D key
BEQ     updateLastKey 
B       .+2 ;If not a valid new key don't change last key
updateLastKey: 
    MOV     R7, R0 
    POP     {R0} 
    RFE

update: 
;Switch on direction of last key
    CMP     R7,#87  
    BEQ     up 
    CMP     R7,#65 
    BEQ     left 
    CMP     R7,#83  
    BEQ     down
    CMP     R7,#68
    BEQ     right
    STR     R11,[R10+R4];Draw new head
    RFE ; Saves registers on the stack

right:
    ADD     R4,R4,#4  ;moves right one pixel
    AND     R0,R4,#255 
    CMP     R0,#0 
    BEQ     gameOver 
    B       reDraw

down: 
    ADD     R4,R4,#256  ;moves down one row
    MOV     R0, #12284 
    CMP     R4,R0 
    BGT     gameOver
    B       reDraw

up: 
    SUB     R4,R4,#256  ;moves up one row
    CMP     R4,#0 
    BLT     gameOver 
    B       reDraw

left: 
    SUB     R4,R4,#4  ;moves left one pixel
    AND     R0,r4,#255 
    CMP     R0,#252 
    BEQ     gameOver

reDraw:  
;First check if the snake would be crossing itself
    LDR     R0,[R10+R4]  
    CMP     R0,R11
    BEQ     gameOver 
    ADD     R6,R6,#4 
    CMP     R6,#limit 
    BLT     .+2 
    MOV     R6, #body
    STR     R4, [R6]
    CMP     R0, R12 ;Check if pixel is apple colour
    BEQ     eat 
    MOV     R0, #.white 
    STR     R0, [R10+R3]  
    ADD     R5,R5,#4 
    CMP     R5,#limit
    BLT     .+2 
    MOV     R5, #body
    LDR     R3,[R5]
    B       .+3 
eat:
    ADD     R8,R8,#1 ;Increment score
    BL      createApple
    STR     R1,[R10+R4] 
    RFE

;Generates apple in random valid location
createApple: 
    push    {R0,R1, LR} 
newRandom: 
    LDR     R1,.Random  ;gets a random 32 bit pattern
    MOV     R0, #0x3ffc  
    AND     R1,R1,R0 
    MOV     R0, #12284  ;Max pixel number
    CMP     R1,R0 
    BGT     newRandom ;'Throw again'
    LDR     R0, [R10+R1] ;Get intended pixel
    CMP     R0,R11  ;Compare pixel to snake colour
    BEQ     newRandom 
    STR     R12, [R10+R1] //Draw apple
    POP     {R0,R1,LR} 
    RET

gameOver: 
    MOV     R0, #over 
    STR     R0,.WriteString 
    MOV     R0, #score 
    STR     R0,.WriteString 
    STR     R8, .WriteSignedNum
    HALT ;To stop program execution running into data area
over: 
    .ASCIZ  " Game Over!\n" 
score: 
    .ASCIZ  "Your score: "
.ALIGN      256 
body:
    .BLOCK  3072 
limit: ;1 past end of queue data
