README - CSCI 5271
HA 1 Exploit #1

Group Members:
1. Zach Larsen (larse702@umn.edu)
2. Jon Huhn (huhnx025@umn.edu)

Vulnerability Description:
This vulnerability was discovered by looking at a group of command-line-style 
commands called "ex mode" in which all of these commands begin with a colon (:)
and go up to the end of the line. The specific vulnerability discovered was one
of the "ex mode" commands (:%!) within BCVI which allowed us to transform the
contents of the buffer through an external program, in this case, our exploit 
script.

Exploit Description:
The problem in bcvi.c is that the ex mode command :%! does not limit what 
commands can be run. Since sudobcvi runs with an effective UID of 0 (root), any 
user could issue any command as root with the :%! command in sudobcvi, including
spawning a root shell. To fix this vulnerability, a whitelist of commands could 
be enforced, which could contain common text manipulation commands like tr or 
expand, while blocking other potentially malicious commands.

Exploit Step-By-Step:
The exploit begins by starting sudobcvi with any valid file, in our 
exploit script we used the following:
"sudobcvi /etc/issue"
Based on the example described in the vulnerability description, we used the :%! 
command to give us (as the test-user) a root shell by running the following 
command in bcvi:
":%!/bin/rootshell"
Any non-provileged user can also run this command and have results identical to 
our exploit script, since sudobcvi has an effective UID of 0 (root).
