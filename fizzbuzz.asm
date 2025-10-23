.data
div5:
    .string "fizz"
div7:
    .string "buzz"
newline:
    .string "\n"
num:
    .string "num"

.text
.globl _start

_start:
    movl    $0, %r8d        # loop counter
loop_start:
    addl    $1, %r8d         # Increment loop counter

    xorl    %r9d, %r9d

    # 5
    movl    %r8d, %eax       # Move loop counter to eax
    xorl    %edx, %edx        # Clear edx before division
    movl    $5, %ecx         # Divisor in ecx
    divl    %ecx              # Divide eax by ecx, quotient in eax, remainder in edx
    cmpl    $0, %edx          # Compare remainder with 0
    jne     try_7
    # 7
    movl    %r8d, %eax       # Move loop counter to eax
    xorl    %edx, %edx        # Clear edx before division
    movl    $7, %ecx         # Divisor in ecx
    divl    %ecx              # Divide eax by ecx, quotient in eax, remainder in edx
    cmpl    $0, %edx          # Compare remainder with 0
    je      div_57
    jmp     div_5

try_7:
    movl    %r8d, %eax       # Move loop counter to eax
    xorl    %edx, %edx        # Clear edx before division
    movl    $7, %ecx         # Divisor in ecx
    divl    %ecx              # Divide eax by ecx, quotient in eax, remainder in edx
    cmpl    $0, %edx          # Compare remainder with 0
    jne     not_57
    jmp     div_7

div_5:
    movl    $div5, %ecx      # Address of "5" (ecx = &div5)
    movl    $4, %edx         # Length of "5" (edx = 1)
    # Kernel
    movl    $4, %eax        # System call number for sys_write (eax = 4)
    movl    $1, %ebx        # File descriptor 1 (stdout) (ebx = 1)
    int     $0x80           # Invoke kernel
    jmp     print_newline

div_7:
    movl    $div7, %ecx      # Address of "5" (ecx = &div5)
    movl    $4, %edx         # Length of "5" (edx = 1)
    # Kernel
    movl    $4, %eax        # System call number for sys_write (eax = 4)
    movl    $1, %ebx        # File descriptor 1 (stdout) (ebx = 1)
    int     $0x80           # Invoke kernel
    jmp     print_newline

div_57:
    movl    $div5, %ecx      # Address of "5" (ecx = &div5)
    movl    $4, %edx         # Length of "5" (edx = 1)
    # Kernel
    movl    $4, %eax        # System call number for sys_write (eax = 4)
    movl    $1, %ebx        # File descriptor 1 (stdout) (ebx = 1)
    int     $0x80           # Invoke kernel

    movl    $div7, %ecx      # Address of "5" (ecx = &div5)
    movl    $4, %edx         # Length of "5" (edx = 1)
    # Kernel
    movl    $4, %eax        # System call number for sys_write (eax = 4)
    movl    $1, %ebx        # File descriptor 1 (stdout) (ebx = 1)
    int     $0x80           # Invoke kernel

    jmp     print_newline

not_57:
    movl    $num, %ecx      # Address of "n" (ecx = &num)
    movl    $3, %edx         # Length of "n" (edx = 1)
    # Kernel
    movl    $4, %eax        # System call number for sys_write (eax = 4)
    movl    $1, %ebx        # File descriptor 1 (stdout) (ebx = 1)
    int     $0x80           # Invoke kernel
    jmp     print_newline


print_newline:
    movl    $newline, %ecx   # Address of newline (ecx = &newline)
    movl    $1, %edx         # Length of newline (edx = 1)
    # Kernel
    movl    $4, %eax        # System call number for sys_write (eax = 4)
    movl    $1, %ebx        # File descriptor 1 (stdout) (ebx = 1)
    int     $0x80           # Invoke kernel

    jmp     check_loop


check_loop:
    cmpl    $40, %r8d       # loop until 10
    jne loop_start


exit_program:
    movl    $1, %eax        # System call number for sys_exit (eax = 1)
    movl    $0, %ebx        # Exit code 0 (ebx = 0)
    int     $0x80           # Invoke kernel
