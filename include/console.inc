.IFNDEF   CONSOLE_INC
.EQU      CONSOLE_INC, 1

/*
 * Print a string to the console.
 */
.MACRO mPRINT_STRING string
    LDR X0, =\string
    BL console_puts
.ENDM

.ENDIF
