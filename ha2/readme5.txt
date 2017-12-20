CSCI 5271 - HA2

huhnx025 - Jon Huhn
larse702 - Zachary Larsen

Our Attack
We injected some Javascript in a comment that would open a pop-up window, making
a HTTP request to our attacker VM with a GET parameter containing the cookie of
the victim. We used netcat to open up network connections to our VM so we could
see the HTTP request being made by the victim. Our attack points to port 8000 on
our attacker VM, so our netcat command had to listen on port 8000. Once the
client is prompted to load the unsafe comment, netcat outputs the HTTP request
made to it, including the victim's cookie.
