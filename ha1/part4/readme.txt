README - CSCI 5271
HA 1 Exploit #4

GROUP MEMBERS
Zach Larsen - larse702@umn.edu
Jon Huhn    - huhnx025@umn.edu

VULNERABILITY
The vulnerability we discovered was a format string vulnerability. To print the
welcome message, BCVI gets the user's name from the USER environment variable.
Since that value becomes part of a buffer that gets used as a format string,
and BCVI does not sanitize the value of the environment variable, BCVI is
vulnerable to a format string attack. By setting the USER environment variable
to a carefully crafted value, we were able to modify the return address of the
snprintf function to return to shellcode we wrote that spawns a rootshell.

STEP-BY-STEP
Much of our attack was modeled after the tutorial that Prof. McCamant posted a
link to on the forum (https://blog.skullsecurity.org/2015/defcon-quals-babyecho-format-string-vulns-in-gory-detail).
To summarize, we had to find where our format string ended up on the stack by
setting the USER environment variable to some number of '%x' format specifiers
to read the data on the stack. Then, we placed a 32-bit hex address in the
string to get BCVI to seg fault on a specific address. The specific address we
chose to overwrite was the return address of snprintf in the welcome_msg
function. We found its return address with GDB. We used the '%n' format
specifier in our string to write data to the memory address we determined
earlier. We can control the value that '%n' writes by padding the string with
the '%x' specifier, since '%n' will write a 32-bit value representing the number
of characters printf has printed so far. Then, to write 4 bytes, we gave the 4
contiguous bytes of memory starting at the location of the return address of
snprintf. We then used 4 '%n' specifiers to write the lower-order byte of these
addresses. Once we could overwrite the return address with 4 1-byte values, we
needed to add some padding with '%x' to modify the return address to be within
the no-op sled in our shellcode. This process was mostly trial and error, and we
stumbled upon a working solution relatively quickly. Once it worked directly on
the VM, however, we found it did not work through the test-exploit script. Then,
we had to script GDB to find the new location of the return address and modify
the memory addresses in our environment variable accordingly. With this slight
modification, our exploit then worked through the script. A copy of our
shellcode is provided below.


SHELLCODE
shellcode:
    push    %ebp
    movl    %esp,%ebp

    # Push a string representing "/bin/rootshell" onto the stack
    push    $0x20206c6c
    push    $0x65687374
    push    $0x6f6f722f
    push    $0x6e69622f

    # Put a null-terminator onto the end of the string
    xorl    %ecx, %ecx
    movb     %cl, -2(%ebp)

    # Load the execve system call into %eax
    xorl    %eax, %eax
    movb    $11, %al

    # Load the string as the first argument
    leal    -16(%ebp), %eax

    # Set the second and third arguments to NULL
    xorl    %ecx, %ecx
    xorl    %edx, %edx

    # Perform the execve system call
    int    $0x80

loop: jmp loop

