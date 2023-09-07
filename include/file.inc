.IFNDEF   FILE_INC
.EQU      FILE_INC, 1

/*
 * Flags for file handling.
 */
.EQU kFILE_RDONLY,              0x000
.EQU kFILE_WRONLY,              0x001
.EQU kFILE_RDWR,                0x002
.EQU kFILE_CREATE,              0x040
.EQU kFILE_TRUNC,               0x200
.EQU kFILE_APPEND,              0x400
.EQU kFILE_ALL_TRUNC,           0x242
.EQU kFILE_ALL_APPEND,          0x442

/*
 * Modes for file handling.
 */
.EQU kFILE_ALREADY_EXISTS,      0x000
.EQU kFILE_USER_PERMISSION,     0x1C0
.EQU kFILE_GROUP_PERMISSION,    0x038
.EQU kFILE_OTHER_PERMISSION,    0x007
.EQU kFILE_ALL_PERMISSIONS,     0x1FF

/*
 * Indicates that the file path is
 * relative to the position of the
 * binary.
 */
.EQU kFILE_RELATIVE_PATH,     -100

/*
 * Controls whether the function file_puts(2)
 * puts an aditional line feed at the end.
 */
.EQU kFILE_PUTS_LINE_FEED, 0

.ENDIF
