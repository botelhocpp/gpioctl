.IFNDEF   PROC_UTILS_LIB
.EQU      PROC_UTILS_LIB, 1

/*
 * Boolean false.
 */
.EQU FALSE, 0

/*
 * Boolean true.
 */
.EQU TRUE, 1

/*
 * Null pointer.
 */
.EQU NULL, 0

/*
 * Enter a procedure. Stores X29 (Frame Register)
 * and X30 (Link Register) in the stack, aligning
 * it by 16 bytes, then, stores SP in X29.
 */
.MACRO mENTER
     STP X29, X30, [SP, #-16]!
     MOV X29, SP
.ENDM   

/*
 * Leave a procedure. Moves X29 back to SP, and pops
 * X29 (Frame Register) and X30 (Link Register) from
 * the stack, maintaning the 16 bytes alignment.
 */
.MACRO mLEAVE
     MOV SP, X29
     LDP X29, X30, [SP], #16
.ENDM  

/*
 * Exits the application with success code.
 */
.MACRO mEXIT_OK
     MOV X0, #0
     BL sysexit
.ENDM

/*
 * Exits the application with failure code.
 */
.MACRO mEXIT_ERROR
     MOV X0, #1
     BL sysexit
.ENDM

.MACRO mGET_ARGC reg
     LDR \reg, [SP, #16]
.ENDM

.MACRO mGET_ARGV reg
     ADD \reg, SP, #24
.ENDM

/*
 * Reserves n blocks of 16-bytes in the stack. 
 */
.MACRO mRESERVE n
     SUB SP, SP, #16*\n
.ENDM

.EQU PUSH, PUSH.L

.EQU POP, POP.L

/*
 * Push one register in the lower 8 bytes of a
 * 16-byte block. 
 */
.MACRO PUSH.L reg
     STR \reg, [SP, #-16]!
.ENDM

/*
 * Push one register in the higher 8 bytes of a
 * 16-byte block. 
 */
.MACRO PUSH.H reg
     STR \reg, [SP, #8]
.ENDM

/*
 * Push two registers in a 16-byte block. 
 */
.MACRO PUSH.P reg1, reg2
     STP \reg1, \reg2, [SP, #-16]!
.ENDM

.MACRO POP.L reg
     LDR \reg, [SP], #16
.ENDM

.MACRO POP.H reg
     LDR \reg, [SP, #8]
.ENDM

.MACRO POP.P reg1, reg2
     LDP \reg1, \reg2, [SP], #16
.ENDM

.MACRO PUSH.F reg
     MRS \reg, NZCV
     PUSH.L \reg
.ENDM

.MACRO POP.F reg
     POP.L \reg
     MSR NZCV, \reg
.ENDM

.ENDIF
