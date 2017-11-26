import urllib
import urllib2
import json
import time
from string import maketrans

#This script refreshes the Questrade access token using the supplied refresh token
#The refresh token is contained in "RefreshToken.txt", which is updated every time the refresh is done
#Refresh token chains must also be manually refreshed weekly in the practice api login page
#Since this is mostly I/O I threw all the IO dependent stuff into Whiles and Trys

#We don't close the file in here since we need to update the refresh token
refresh = ""
while refresh == "":
    try:
        refreshFile = open ("RefreshToken.txt", "r+")
    except IOError:
        time.sleep(1)
    else:
        refresh = refreshFile.readline()

#Build the URL to request new access token. Need to do it this way since including Data in the request turns it into a POST instead of GET
url = "https://practicelogin.questrade.com/oauth2/token?grant_type=refresh_token&" + urllib.urlencode({"refresh_token" : refresh})

req = urllib2.Request(url) 

#Try to open the web page, if we get an HTTP400 then the token is invalid or not ready to be refreshed yet
try:
        resp = urllib2.urlopen(req).read()
        
#We can probably get rid of this later
except urllib2.HTTPError as err:
        if err.code == 400:
                print "Refresh not ready or wrong refresh given"

#If we didn't get an error, then we got a JSON-encoded response
else:
    #Read the JSON response, assuming UTF-8 encoding
    jsonContent = json.loads(resp.decode("utf-8"))
    
    #JSON docs are treated as dictionaries in Python, so just read the fields we need
    access = jsonContent["access_token"]
    newRefresh = jsonContent["refresh_token"]
    server = jsonContent["api_server"].replace("\\", "")
    
    #manual validation lines
    print access + "\n"
    print newRefresh + "\n"
    print server + "\n"

    #Try to open the access token file to write the new token into
    fileopened = False
    while not fileopened:
            try: 
                    accfile = open ("AccessToken.txt", "w")
            except IOError:
                    time.sleep(1)
            else:
                    fileopened = True
                    accfile.write(access + "\n")
                    accfile.write(server)
                    accfile.close()
                    #Need to seek the start of the file since the buffer moved on read above
                    refreshFile.seek(0,0)
                    refreshFile.write(newRefresh)
                    
#Putting this down here because shenanigans                    
refreshFile.close()