CSCI 5271 - HA2

huhnx025 - Jon Huhn
larse702 - Zachary Larsen

Password Cracker
We installed a dictionary package called wamerican-insane to use as the source
for our attack, accessible as a file at /usr/share/dict/words. Our password
cracker tries every word from the dictionary in sequence for one that hashes to
the same value as the response value in the packet we sniffed. We found the HTTP
digest authentication specification on Wikipedia
(https://en.wikipedia.org/wiki/Digest_access_authentication). For each word in
the dictionary, we calculate a new hash according to the specification and the
values from the sniffed packet. If the hashes match, then the password we
guessed can be used to access the file at http://server/secret/cheese.php.

Password
bonehead
