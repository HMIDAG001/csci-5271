#!/usr/bin/env python3

import requests
import urllib3

urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)

s = requests.Session()
s.verify = False


def get_mac(username):
    r = s.get('https://192.168.3.1/mac-cookie.php',
              params={'username': username})
    mac = r.text[-42:-2]
    return mac

key = ''

for i in list(range(20)):
    u = '0' * (20 - 1 - i)
    k = get_mac(u)
    for j in list(range(256)):
        if k == get_mac(u + key + chr(j)):
            key += chr(j)
            break


if get_mac('') == get_mac(key):
    print('Found key. Key = {}'.format(key))
else:
    print('Key {} is incorrect'.format(key))
