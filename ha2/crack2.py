#!/usr/bin/env python3

from hashlib import md5
import sys

method = "HEAD"
username = "seoh3"
realm = "Cheese"
nonce = "AnwSrmldBQA=29c8004e1c037bf9046b67e1f34e165f2b27e6e9"
uri = "/secret/cheese.php"
cnonce = "ZjgwZTAxMTQ3YTdjYWVlNzQ4OWE1ZmViZjZlMDE5ZTk="
nc = "00000001"
qop = "auth"
response_goal = "3fb2216945b3dff9a0f45c8ba112dfc7"

ha2 = md5("{}:{}".format(method, uri).encode("utf-8")).hexdigest()


def try_password(password):
    ha1 = md5("{}:{}:{}".format(
        username, realm, password).encode("utf-8")).hexdigest()
    response = md5("{}:{}:{}:{}:{}:{}".format(
        ha1, nonce, nc, cnonce, qop, ha2).encode("utf-8")).hexdigest()
    return response == response_goal

with open('/usr/share/dict/words') as words:
    word = words.readline()[:-1]
    while word:
        if try_password(word):
            print("Password is {}".format(word))
            break
        word = words.readline()[:-1]
