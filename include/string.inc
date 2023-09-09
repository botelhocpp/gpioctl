.IFNDEF   STRING_INC
.EQU      STRING_INC, 1

.MACRO mSTRING_COPY reg, string
    LDR X1, =\string
    MOV X0, \reg
    BL string_copy
.ENDM

.MACRO mSTRING_EQUALS reg, string
    LDR X1, =\string
    MOV X0, \reg
    BL string_equals
.ENDM

.MACRO mSTRING_APPEND reg, string
    LDR X1, =\string
    MOV X0, \reg
    BL string_append
.ENDM

.ENDIF
