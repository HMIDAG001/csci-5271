CSCI 5271 - HA2

huhnx025 - Jon Huhn
larse702 - Zachary Larsen

cookies3.txt Construction
We made our cookies3.txt by observing that the loginAuth cookie was sent to the
client whenever a registered user logged in to the website. We also noticed that
the cookie's value was the username followed by the date and time the user
registered. We found the date that the Stephen user registered by attempting to
log in as Stephen. Even when providiing a bogus password, the login process
appears to succeed, and the date that the Stephen user registered is shown. We
had registered a test1 user and noticed that the time in the cookie was GMT
while the displayed time was local time. Adjusting the Stephen user's time by
the same amount gave almost the correct answer, but we had to adjust by one hour
for daylight savings time.

Admin Page Contents
<!doctype html>
<head>
	<title>Admin</title>
</head>
<body>
<p><strong>Welcome back, Stephen!</strong></p><p>You have <strong>5</strong> new messages.</p><ul>
		<li><strong>Richard Stallman</strong> - Subj: Stuck on HA2 problem 3</li>
		<li><strong>Patrick Bateman</strong>  - Subj: Re: Did you return the textbook?</li>
		<li><strong>Lil Wayne</strong>        - Subj: Recommendation on papers?</li>
		<li><strong>Se Eun Oh</strong>   - Subj: Delay on grading HA2</li>
		<li><strong>Jack Handey</strong> - Subj: Happy Thanksgiving!</li>
	</ul><img src="../img/hacking.gif"></body>
</html>
