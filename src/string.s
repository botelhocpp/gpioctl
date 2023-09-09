.INCLUDE "string.inc" 

.INCLUDE "proc_utils.inc"   

.TEXT

/*
 * Copies the second string to the first one, returning it's
 * size.
 * 
 * C Prototype: size_t string_copy(char *str1, const char *str2);
 */
.GLOBAL string_copy
string_copy:
    mENTER

    MOV X3, XZR
    CBZ X0, __string_copy_end
    CBZ X1, __string_copy_end

    __string_copy_copying:
        LDRB W2, [X1, X3] 
        CBZ W2, __string_copy_end_of_string
        STRB W2, [X0, X3]
        ADD X3, X3, #1
        B __string_copy_copying

    __string_copy_end_of_string:
        STRB WZR, [X0, X3]
    
    __string_copy_end:
    MOV X0, X3
    mLEAVE
    RET

/*
 * Return the length of the given string.
 * 
 * C Prototype: size_t string_length(const char *str);
 */
.GLOBAL string_length
string_length:
    mENTER

    MOV X1, X0
    MOV X0, XZR

    CBZ X1, __string_length_end

    __string_length_couting:
        LDRB W2, [X1], #1
        CBZ W2, __string_length_end
        ADD X0, X0, #1
        B __string_length_couting

    __string_length_end:
    mLEAVE
    RET

/*
 * Checks whether the two given stringd are equal.
 * 
 * C Prototype: bool string_equals(const char *str1, const char *str2);
 */
.GLOBAL string_equals
string_equals:
    mENTER

    CMP X0, X1
    B.EQ __string_equals_set_boolean
    CBZ X0, __string_equals_null_string
    CBZ X1, __string_equals_null_string

    __string_equals_checking:
        LDRB W2, [X0], #1
        LDRB W3, [X1], #1 
        CBZ W2, __string_equals_check_end
        CBZ W3, __string_equals_check_end
        CMP W2, W3
        B.EQ __string_equals_checking

    __string_equals_check_end:
        CMP W2, W3

    __string_equals_set_boolean:
        CSET X0, EQ

    __string_equals_end:
    mLEAVE
    RET

    __string_equals_null_string:
        MOV X0, FALSE
        B __string_equals_end

/*
 * Append the second string onto the first one.
 * 
 * C Prototype: size_t string_append(char *str1, const char *str2);
 */
.GLOBAL string_append
string_append:
    mENTER

    CBZ X0, __string_append_null_string
    CBZ X1, __string_append_null_string

    MOV X2, XZR // str1 size
    MOV X4, XZR // str2 size

    __string_append_str1_size:
        LDRB W3, [X0, X2]
        CBZ W3, __string_append_save_str1_size
        ADD X2, X2, #1
        B __string_append_str1_size

    __string_append_save_str1_size:
    MOV X6, X2
    __string_append_appending:
        LDRB W5, [X1, X4]
        CBZ W5, __string_append_end_of_string
        STRB W5, [X0, X2]
        ADD X2, X2, #1
        ADD X4, X4, #1
        B __string_append_appending

    __string_append_end_of_string:
        STRB WZR, [X0, X2]
        ADD X0, X6, X4

    __string_append_end:
    mLEAVE
    RET

    __string_append_null_string:
        MOV X0, #0
        B __string_append_end

/*
 * Converts a null terminating string to a 
 * 32-bits integer.
 * 
 * C Prototype: int string_to_int(const char *str);
 */
.GLOBAL string_to_int
string_to_int:
    mENTER

    CBZ X0, __string_to_int_null_string

    MOV X1, X0
    MOV X0, XZR
    MOV X2, XZR
    MOV X5, #+1
    MOV X10, #10

    __string_to_int_signal:
        LDRB W2, [X1], #1
        CMP X2, #'-'
        B.NE __string_to_int_converting
        MOV X5, #-1

    LDRB W2, [X1], #1
    __string_to_int_converting:
        CBZ X2, __string_to_int_get_signal
        CMP X2, #'0'
        B.LO __string_to_int_get_signal
        CMP X2, #'9'
        B.HI __string_to_int_get_signal
        MUL X3, X0, X10
        SUB X4, X2, #'0'
        ADD X0, X3, X4
        LDRB W2, [X1], #1
        B __string_to_int_converting

    __string_to_int_get_signal:
        MUL X0, X0, X5
    
    __string_to_int_end:
    mLEAVE
    RET

    __string_to_int_null_string:
        MOV X0, #0
        B __string_to_int_end

/*
 * Converts an unsigned integer to a string, and
 * returns the address to the string.
 * 
 * C Prototype: char *int_to_string(unsigned int number, char *str);
 */
.GLOBAL int_to_string
int_to_string:
    mENTER

    CBZ X1, __int_to_string_null_string

    MOV X2, X0
    MOV X3, XZR
    MOV X10, #10

    __int_to_string_size:
        UDIV X2, X2, X10
        ADD X3, X3, #1
        CBNZ X2, __int_to_string_size
    
    STRB WZR, [X1, X3]
    __int_to_string_converting:
        SUB X3, X3, #1
        UDIV X2, X0, X10
        MSUB X4, X2, X10, X0
        ADD X5, X4, '0'
        STRB W5, [X1, X3]
        MOV X0, X2
        CBNZ X3, __int_to_string_converting

    MOV X0, X1

    __int_to_string_end:
    mLEAVE
    RET

    __int_to_string_null_string:
        MOV X0, #0
        B __int_to_string_end
