README - CSCI 5271
HA 1 Exploit #1

Group Members:
1. Zach Larsen (larse702@umn.edu)
2. Jon Huhn (huhnx025@umn.edu)

VULNERABILITY
The vulnerability we found was similar to the previous week's. The problem lies 
in how bcvi checks for sudo permissions. In the check_sudo_mode function, 
sudo_mode is determined by the first command line argument, which is the name of 
the executable. This filename can be easily changed through links, however. By 
linking the sudobcvi executable to a new file called bcvi or anything else, 
sudo_mode is not turned on in the program, but it still runs with the same root 
permissions as sudobcvi.Since bcvi uses the sudo_mode variable to determine 
whether or not to sanitize input to filter_buffer, this sanitization can be 
disabled by invoking sudobcvi with any command other than `sudobcvi`, such as 
the name of an executable linked to it. This allows any shell command to be 
executed with the :%! ex-mode command with root privileges. To fix this 
vulnerability, bcvi should check for its effective UID instead of the first 
command line argument. 

STEP-BY-STEP
First, the script creates a link from /usr/bin/sudobcvi to ~/bcvi. Then, 
`./bcvi` can be invoked with any file as an argument. Finally, a rootshell is 
obtained with the ex-mode command `:%!/bin/rootshell`.
