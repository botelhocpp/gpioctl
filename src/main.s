.INCLUDE "console.inc"
.INCLUDE "file.inc"
.INCLUDE "proc_utils.inc"

.BALIGN 8
.DATA

.TEXT

.GLOBAL _start
_start:
    mENTER

_end:
    mLEAVE
    mEXIT_OK
