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
url = server + "v1/symbols?ids="
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
	updURL = "http://vassairm.dev.fast.sheridanc.on.ca/StockAgent/PyLongUpdate.php"
	updHead = {'Content-Type': 'application/json'}
	updData = json.dumps(quoteJSON['symbols']).encode('utf-8') #updData should be a JSON doc containing a list, change list entries into associative arrays in php
	#build and send the request
	updReq = urllib2.Request(updURL, updData, updHead)
	updResp = urllib2.urlopen(updReq).read()
	
	print updResp #for testing purposes
	


################# Results of a symbol search on "GOO" THIS INCLUDES DESCRIPTION ###########################
#{"symbols":[
#{"symbol":"GOOD","symbolId":20133,"description":"GLADSTONE COMMERCIAL CP","securityType":"Stock","listingExchange":"NASDAQ","isTradable":true,"isQuotable":true,"currency":"USD"},
#{"symbol":"GOODM","symbolId":13918014,"description":"GLADSTONE COMMERICAL CORP PFD SR","securityType":"Stock","listingExchange":"NASDAQ","isTradable":true,"isQuotable":true,"currency":"USD"},
#{"symbol":"GOODO","symbolId":20135,"description":"GLADSTONE COMMERCIAL CORP 7.50%","securityType":"Stock","listingExchange":"NASDAQ","isTradable":true,"isQuotable":true,"currency":"USD"},
#{"symbol":"GOODP","symbolId":20134,"description":"GLADSTONE COMMERCIAL CORP 7.75%","securityType":"Stock","listingExchange":"NASDAQ","isTradable":true,"isQuotable":true,"currency":"USD"},
#{"symbol":"GOOG","symbolId":11419765,"description":"ALPHABET CL C CAPITAL STOCK","securityType":"Stock","listingExchange":"NASDAQ","isTradable":true,"isQuotable":true,"currency":"USD"},
#{"symbol":"GOOGL","symbolId":11419766,"description":"ALPHABET CL A","securityType":"Stock","listingExchange":"NASDAQ","isTradable":true,"isQuotable":true,"currency":"USD"},
#{"symbol":"GOOI","symbolId":9452246,"description":"GOOI GLOBAL INC","securityType":"Stock","listingExchange":"PINX","isTradable":true,"isQuotable":true,"currency":"USD"},
#{"symbol":"GOOO","symbolId":12589957,"description":"GOOOGREEN INC","securityType":"Stock","listingExchange":"PINX","isTradable":true,"isQuotable":true,"currency":"USD"},
#{"symbol":"GOOS","symbolId":16942723,"description":"CANADA GOOSE HOLDINGS","securityType":"Stock","listingExchange":"NYSE","isTradable":true,"isQuotable":true,"currency":"USD"},
#{"symbol":"GOOS.TO","symbolId":16942709,"description":"CANADA GOOSE HOLDINGS INC","securityType":"Stock","listingExchange":"TSX","isTradable":true,"isQuotable":true,"currency":"CAD"},
#{"symbol":"GOOXF","symbolId":46236,"description":"GIVOT OLAM OIL EXPL","securityType":"Stock","listingExchange":"PINX","isTradable":true,"isQuotable":true,"currency":"USD"},
#{"symbol":"CMPZF","symbolId":3166789,"description":"GOODMAN GOLD TRUST","securityType":"Stock","listingExchange":"PINX","isTradable":true,"isQuotable":true,"currency":"USD"},
#{"symbol":"FOOD.TO","symbolId":17821823,"description":"GOODFOOD MARKET CORP","securityType":"Stock","listingExchange":"TSX","isTradable":true,"isQuotable":true,"currency":"CAD"},
#{"symbol":"GBBYF","symbolId":2423850,"description":"GOODBABY INTERNATIONAL HOLDINGS","securityType":"Stock","listingExchange":"PINX","isTradable":true,"isQuotable":true,"currency":"USD"},
#{"symbol":"GDDFF","symbolId":18409970,"description":"GOODFOOD MKT CORP COM","securityType":"Stock","listingExchange":"PINX","isTradable":true,"isQuotable":true,"currency":"USD"},
#{"symbol":"GDL.TO","symbolId":20673,"description":"GOODFELLOW INC","securityType":"Stock","listingExchange":"TSX","isTradable":true,"isQuotable":true,"currency":"CAD"},
#{"symbol":"GDNP.VN","symbolId":19352202,"description":"GOOD NATURED PRODUCTS INC","securityType":"Stock","listingExchange":"TSXV","isTradable":true,"isQuotable":true,"currency":"CAD"},
#{"symbol":"GDP","symbolId":15870553,"description":"GOODRICH PETE CORP COM PAR $","securityType":"Stock","listingExchange":"NYSEAM","isTradable":true,"isQuotable":true,"currency":"USD"},
#{"symbol":"GDWWF","symbolId":9452253,"description":"GOODWIN PLC ORD UNITED KINGDOM","securityType":"Stock","listingExchange":"PINX","isTradable":true,"isQuotable":true,"currency":"USD"},
#{"symbol":"GLCC","symbolId":20670,"description":"GOOD LIFE CHINA CORPORATION","securityType":"Stock","listingExchange":"PINX","isTradable":true,"isQuotable":true,"currency":"USD"}]}

######################## Results of a quote for Google (now Alphabet Company) ##############################
#{"symbols":[{"symbol":"GOOG","symbolId":11419765,"prevDayClosePrice":1034.49,"highPrice52":1048.39,"lowPrice52":737.02,"averageVol3Months":1321298,"averageVol20Days":1400992,
#"outstandingShares":349479000,"eps":29.89,"pe":34.61,"dividend":0,"yield":0,"exDate":null,"marketCap":361532530710,"tradeUnit":1,"optionType":null,"optionDurationType":null,"optionRoot":"",
#"optionContractDeliverables":{"underlyings":[],"cashInLieu":0},"optionExerciseType":null,"listingExchange":"NASDAQ","description":"ALPHABET CL C CAPITAL STOCK","securityType":"Stock",
#"optionExpiryDate":null,"dividendDate":null,"optionStrikePrice":null,"isTradable":true,"isQuotable":true,"hasOptions":true,"currency":"USD","minTicks":[{"pivot":0,"minTick":0.0001},{"pivot":1,"minTick":0.01}],
#"industrySector":"Technology","industryGroup":"OnlineMedia","industrySubgroup":"InternetContentInformation"}]}