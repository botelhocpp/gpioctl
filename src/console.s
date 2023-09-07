.INCLUDE "console.inc" 

.INCLUDE "proc_utils.inc" 
.INCLUDE "syscall_id.inc" 
.INCLUDE "system.inc" 

.TEXT

/*
 * Print one character to the console.
 * 
 * C Prototype: void console_putc(char c);
 */
.GLOBAL console_putc
console_putc:
     mENTER

     PUSH.L W0

     MOV X0, #kSTDOUT
     MOV X1, SP
     MOV X2, #1
     MOV X8, #kWRITE
     SVC #0

     mLEAVE
     RET

/*
 * Obtain and return one character from
 * the console.
 * 
 * C Prototype: char console_getc(void);
 */
.GLOBAL console_getc
console_getc:
     mENTER
     mRESERVE 1

     MOV X0, #kSTDIN
     MOV X1, SP
     MOV X2, #1
     MOV X8, #kREAD
     SVC #0

     LDRB W0, [SP]
     AND W0, W0, #0xFF

     mLEAVE
     RET

/*
 * Print a string to the console.
 * 
 * C Prototype: void console_puts(const char *str);
 */
.GLOBAL console_puts
console_puts:
     mENTER

     MOV X1, X0
     MOV X2, #1
     MOV X8, #kWRITE
     __console_puts_printing:
          LDRB W3, [X1]
          CBZ W3, __console_puts_end
          MOV X0, #kSTDOUT
          SVC #0
          ADD X1, X1, #1
          B __console_puts_printing
          
     __console_puts_end:
.IF kCONSOLE_PUTS_LINE_FEED
          MOV X0, #0x0A
          BL console_putc
.ENDIF
     mLEAVE
     RET

/*
 * Obtain one string from the console and returns
 * it's size.
 * 
 * C Prototype: size_t console_gets(char *str);
 */
.GLOBAL console_gets
console_gets:
     mENTER
     
     MOV X3, #0

     MOV X1, X0
     MOV X2, #1
     MOV X8, #kREAD
     __console_gets_reading:
          MOV X0, #kSTDIN
          SVC #0
          LDRB W0, [X1], #1
          CMP W0, #0x0A
          B.EQ __console_gets_end
          ADD X3, X3, #1
          B __console_gets_reading
              
     __console_gets_end:
     MOV W4, #0
     STRB W4, [X1, #-1]
     MOV X0, X3
     mLEAVE
     RET

