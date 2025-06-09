'----------------------------------------------------
' Automatic resolution routine Robot Tower-of-Hanoi
' IntyBASIC
' https://github.com/rodineyhm
'----------------------------------------------------
INCLUDE "constants.bas"
CONST TWAIT = 30
CONST LEVEL = 3 'number of disks (from 3 to MAX_HEIGHT)
CONST NUM_TOWERS = 3
CONST MAX_HEIGHT = 10
DIM TOWERS(NUM_TOWERS * MAX_HEIGHT)
DIM TOP(NUM_TOWERS)
#MOVES = 0 

FOR i = 0 TO LEVEL - 1
    TOWERS(0 * MAX_HEIGHT + i) = LEVEL - i
NEXT i
TOP(0) = LEVEL - 1
TOP(1) = -1
TOP(2) = -1
STACK_POS = 0
DIM STACK_FROM(MAX_HEIGHT), STACK_TO(MAX_HEIGHT), STACK_AUX(MAX_HEIGHT), STACK_N(MAX_HEIGHT), STACK_STATE(MAX_HEIGHT)
STACK_FROM(STACK_POS) = 0
STACK_TO(STACK_POS) = 2
STACK_AUX(STACK_POS) = 1
STACK_N(STACK_POS) = LEVEL
STACK_STATE(STACK_POS) = 0
STACK_POS = STACK_POS + 1
PRINT AT SCREENPOS(6,11) COLOR CS_TAN, "Resolving..."
'-------------
LOOP_RESOLUTION:
    IF STACK_POS = 0 THEN 
        PRINT AT SCREENPOS(6,11) COLOR CS_TAN, "Resolved!   "
        GOTO END
    END IF
    STACK_POS = STACK_POS - 1
    FROM = STACK_FROM(STACK_POS)
    TO_ = STACK_TO(STACK_POS)
    AUX = STACK_AUX(STACK_POS)
    N = STACK_N(STACK_POS)
    STATE = STACK_STATE(STACK_POS)
    IF N = 1 THEN
        GOSUB MOVE
        GOTO LOOP_RESOLUTION
    END IF
    IF STATE = 0 THEN
        'STATE 1
        STACK_FROM(STACK_POS) = FROM
        STACK_TO(STACK_POS) = TO_
        STACK_AUX(STACK_POS) = AUX
        STACK_N(STACK_POS) = N
        STACK_STATE(STACK_POS) = 1
        STACK_POS = STACK_POS + 1
        'DISKs FROM -> AUX
        STACK_FROM(STACK_POS) = FROM
        STACK_TO(STACK_POS) = AUX
        STACK_AUX(STACK_POS) = TO_
        STACK_N(STACK_POS) = n - 1
        STACK_STATE(STACK_POS) = 0
        STACK_POS = STACK_POS + 1
        WAIT
        GOTO LOOP_RESOLUTION
    ELSEIF STATE = 1 THEN
        GOSUB MOVE
        'FROM AUX -> TO_
        STACK_FROM(STACK_POS) = AUX
        STACK_TO(STACK_POS) = TO_
        STACK_AUX(STACK_POS) = FROM
        STACK_N(STACK_POS) = N - 1
        STACK_STATE(STACK_POS) = 0
        STACK_POS = STACK_POS + 1
        GOTO LOOP_RESOLUTION
    END IF
'-------------
MOVE: PROCEDURE
    DISC = TOWERS(FROM * MAX_HEIGHT + TOP(FROM))
    TOWERS(FROM * MAX_HEIGHT + TOP(FROM)) = 0
    TOP(FROM) = TOP(FROM) - 1
    TOP(TO_) = TOP(TO_) + 1
    TOWERS(TO_ * MAX_HEIGHT + TOP(TO_)) = DISC
    #MOVES = #MOVES + 1
    PRINT AT SCREENPOS(1,3), "Disc :",<1>DISC -1
    PRINT AT SCREENPOS(1,4), "From :",<1>FROM +1
    PRINT AT SCREENPOS(1,5), "To   :",<1>TO_  +1
    PRINT AT SCREENPOS(1,6), "Moves:",<8>#MOVES
    FOR delay = 1 TO TWAIT: WAIT: NEXT
    RETURN
    END

END:

