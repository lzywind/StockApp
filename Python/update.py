import urllib
import urllib2
import json
import subprocess as sub
from time import sleep

symbols = []
IODone = False
accessKey = ""
server = ""

#Read in the symbols we want to update. File should only be locked while we're manually editing it
#This expects they symbol file to contain the Questrade symbol IDs
#As an alternative we can grab from SQL, but more resource intensive
with open("symbols.txt", "r") as symfile:
	for line in symfile:
		symbols.append(line)

#Grab the access token and the base URL as set in refresh.py
#refresh.py might have this open at the time, so I bungled together a retry mechanism
while not IODone:
	with open("AccessToken.txt", "r") as access:
		accessKey = access.readline().rstrip()
		server = access.readline().rstrip()
		IODone = True
		print accessKey
		print server
		
	if not IODone:
		time.sleep(1)
		
#Build the Request URL. Because urllib2.Request() creates a POST if I use params, I need to build them into the base URL...
#as urllib2 creates a get if no params are supplied. Kinda dumb.
url = server + "v1/markets/quotes?ids="
for ids in symbols:
	url = url + ids.rstrip() + ","
	
url = url.rstrip(',')
#Add the authorization header to the request	
auth = {"Authorization" : "Bearer " + accessKey}
print url
request = urllib2.Request(url, headers = auth)

#Try and get the quote(s) requested
#THE FORMAT OF THE RESPONSE IS A DICT CONTAINING A LIST OF RESULTS, WHERE EACH RESULT IS A DICT
#ALSO NOTE THAT ALL STRINGS WILL BE UNICODE, LIKE: u'Unicode String'.
#Probably wont need to worry about that, but keep it in mind
try:
	response = urllib2.urlopen(request).read()
except urllib2.URLError as err:
	print err.reason
else:
	#grab the JSON response and convert it into a dictionary
	quoteJSON = json.loads(response.decode("utf-8"))
	print quoteJSON
	#Prep update variables, and strip outer dict from Questrade Response
	updURL = "http://vassairm.dev.fast.sheridanc.on.ca/StockAgent/PyUpdate.php"
	updHead = {'Content-Type': 'application/json'}
	updData = json.dumps(quoteJSON['quotes']).encode('utf-8') #updData should be a JSON doc containing a list, change list entries into associative arrays in php
	#build and send the request
	updReq = urllib2.Request(updURL, updData, updHead)
	updResp = urllib2.urlopen(updReq).read()
	
	print updResp #for testing purposes