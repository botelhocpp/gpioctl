.INCLUDE "file.inc" 
.INCLUDE "proc_utils.inc" 
.INCLUDE "syscall_id.inc" 
.INCLUDE "system.inc" 

.TEXT

/*
 * Opens a file with given flags (file handling options) 
 * and mode (permissions) and returns it's descriptor (fd).
 * 
 * C Prototype: FILE* file_open(const char* path, int flags, int mode);
 */
.GLOBAL file_open
file_open:
     mENTER

     MOV X3, X2
     MOV X2, X1
     MOV X1, X0
     MOV X0, #kFILE_RELATIVE_PATH
     MOV X8, #kOPEN
     SVC #0

     mLEAVE
     RET

/*
 * Closes a file whose fd has been given.
 * 
 * C Prototype: void file_close(FILE* fd);
 */
.GLOBAL file_close
file_close:
     mENTER

     CMP X0, kSTDERR
     B.LE __file_close_end

     MOV X8, #kCLOSE
     SVC #0

     __file_close_end:
     mLEAVE
     RET

/*
 * Obtain the current line of the file with given fd,
 * and returns itss size.
 * 
 * C Prototype: size_t file_gets(FILE* fd, char *str);
 */
.GLOBAL file_gets
file_gets:
     mENTER
     
     MOV X3, #0
     MOV X4, X0

     MOV X2, #1
     MOV X8, #kREAD
     __file_gets_reading:
          SVC #0
          CBZ X0, __file_gets_end
          LDRB W0, [X1], #1
          CMP W0, #0x0A
          B.EQ __file_gets_end
          CBZ W0, __file_gets_end
          ADD X3, X3, #1
          MOV X0, X4
          B __file_gets_reading
              
     __file_gets_end:
     MOV W4, #0
     STRB W4, [X1, #-1]
     MOV X0, X3
     mLEAVE
     RET

/*
 * Put the given string in the file with given fd. The
 * insertion process will depend on the file settings.
 * 
 * C Prototype: void file_puts(FILE* fd, const char *str);
 */
.GLOBAL file_puts
file_puts:
     mENTER

     MOV X4, X0

     MOV X2, #1
     MOV X8, #kWRITE
     __file_puts_printing:
          LDRB W3, [X1]
          CBZ W3, __file_puts_end
          MOV X0, X4
          SVC #0
          ADD X1, X1, #1
          B __file_puts_printing
          
     __file_puts_end:
.IF kFILE_PUTS_LINE_FEED
          MOV X5, #0x0A
          PUSH X5
          MOV X1, SP
          MOV X0, X4
          SVC #0
.ENDIF
     mLEAVE
     RET
