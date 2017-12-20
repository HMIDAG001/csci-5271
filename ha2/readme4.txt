CSCI 5271 - HA2

huhnx025 - Jon Huhn
larse702 - Zachary Larsen

How Our Attack Works
Our attack works by injecting attacker-controlled SQL into the HTTP POST data we
send. Since the value of "picture" in the POST data is likely enclosed in quotes
in the SQL query sent to the database, we first add an extra single-quote to
close off that pair. Then, we are free to write any extra SQL we want. We guess
that the query is something like the following:

SELECT *
FROM Thoughts
WHERE picture='$picture' AND username='seoh';

where $picture is the value we pass into the POST request. We add the SQL
"and username='alice';" after our single-quote, resulting in a query like

SELECT *
FROM Thoughts
WHERE picture='infinitejest.jpg' and username = 'alice';' AND username='seoh';

Everything after the semi-colon is ignored, so our injected SQL results in a
query that asks for alice's secret thought on the infinitejest.jpg picture.


Our Request
curl -k -X POST -d "picture=infinitejest.jpg' and username = 'alice';" https://$SERVER/thought.php


Alice's Secret Thought
32 people were rescued from the sinking ferry.
