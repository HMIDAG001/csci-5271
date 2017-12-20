CSCI 5271 - HA2

huhnx025 - Jon Huhn
larse702 - Zachary Larsen

Our Attack
Since we know the server will hash the first 20 characters of the username and
key combination, we can send a 19-character username, which will also use the
first character of the key. Once we know the MAC for the 19-character string
plus the first byte of the key, we can compute the MAC of the same 19-character
string plus each of the 256 possible 1-character suffixes. One of these must be
the same as the MAC of the 19-character string by itself, meaning the last
character is the same as the first character of the key. Then, the process
repeats. We send an 18-character username, and then search the 256 possible
combinations of the same username, the portion of the key we've found so far,
and our guess for the next character of the key. We execute this process 20
total times to get the full key. At the end, we check that the MAC of the key is
the same as the MAC of an empty username.

Key
iPo2bqk8Y1EOeZe9Nnf8
