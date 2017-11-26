import urllib
import urllib2
import time


access = ""

while access == "":
	try:
		inf = open("AccessToken.txt")
	except IOError:
		time.wait(1)
	else:
		access = inf.readline()

print access