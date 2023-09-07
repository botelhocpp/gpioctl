.IFNDEF   CONSOLE_INC
.EQU      CONSOLE_INC, 1

/*
 * Controls whether the function console_puts(1)
 * prints an aditional line feed at the end.
 */
.EQU kCONSOLE_PUTS_LINE_FEED, 1

/*
 * Print a string to the console.
 */
.MACRO mPRINT_STRING string
    LDR X0, =\string
    BL console_puts
.ENDM

.ENDIF
