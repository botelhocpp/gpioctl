.INCLUDE "system.inc" 

.INCLUDE "proc_utils.inc" 
.INCLUDE "syscall_id.inc" 

.TEXT

/*
 * Exit the programm.
 * 
 * C Prototype: void sysexit(int code);
 */
.GLOBAL sysexit
sysexit:
    MOV X8, #kEXIT
    SVC #0
