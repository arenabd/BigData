# -*- coding: utf-8 -*-

from HTMLParser import HTMLParser
from copy import copy
import requests
import re
import sys
import json
import time
import datetime
import os

def getDate():
    ts = time.time()
    dt = datetime.datetime.fromtimestamp(ts).strftime('%Y.%m.%d')
    return dt

def getTimeStamp():
    ts = time.strftime("%Y-%m-%dT%H:%M:%S.000Z", time.gmtime())
    return ts

dataParsed = list()
dataJson = list()
dictJsonList = list()
date = getDate()
timestamp = getTimeStamp()
url = u"http://195.154.168.76:9200/test-" +  date + "/BALO/"
#url = u"http://195.154.168.76:9200/test-2014.03.25/BALO/"
reqJson = ""
dictJson = {}
logFile = ""

f = open('/home/arenasi/Maquette/elasticsearch/elasticsearch-0.90.9/scripts/BALO_python/html_parser.log', 'ar+')
f.write('*************************************\n')
f.write('***  Lancement du script : ' + getTimeStamp() + '-UTC \n')
f.write('*************************************\n')

#Creation d'une sous-classe et surcharge des fonctions
class MyHTMLParser(HTMLParser):
    def handle_data(self, data):
        str = data.replace("\n", "")
        str = str.replace("  ", "")
        str = str.replace("\t", "")
        str = str.replace("\r", "")
 #       print "Encountered some data  :", str
        if u'Société :' in str or 'RCS :' in str or u'Catégorie :' in str or u'N° d\'affaire :' in str \
                or 'Annonce au format' in str or "Paru le :" in str or u'Parution n°' in str:
            dataParsed.append(str)

#Conversion de la chaine Html en Json
def HtmlToJson(dataHtml):
    req = reqJson
    for item in dataHtml:
        if u'Société :' in item:
            dictJson[u'Société'] = item[11:]
#            print dictJson[u'Société']
        elif u'RCS :' in item:
            dictJson[u'RCS'] = item[6:]
#           print dictJson['RCS']
        elif u'Catégorie :' in item:
            dictJson[u'Catégorie'] = item[12:]
#            print dictJson[u'Catégorie']
        elif u'N° d\'affaire :' in item:
            dictJson[u'_id'] = item[16:]
#            print dictJson[u'_id']
        elif u'Paru le :' in item:
            dictJson[u'Paru le'] = item[10:]
#            print dictJson[u'Paru le']
        elif u'Parution n°' in item:
            dictJson[u'Parution n°'] = item[12:].replace(")", "")
#            print dictJson[u'Parution n°']
        elif u'Annonce au format' in item:
            dictJson[u'Annonce pdf / htm'] = item[18:]
#            print dictJson[u'Annonce pdf / htm']
            dictJsonList.append(copy(dictJson))
            dictJson.clear()
def ParseRequest(req):
    # Parse l'html de request
    rexp = re.compile('<div class="hr"><hr/></div>((.|\n)*)</b></a></p>')
    res = rexp.search(req.text)
    
    if res:
        str = res.group(1)
        str = str.replace("\t", "")
        str = str.replace("  ", "")
        str = str.replace("\n\n", "")
        str = str.replace("<div align=\"right\">", "")
        str = str.replace("<div class=\"hr\"><hr/></div>", "")
        str = str.replace("&Eacute;", "E")
        str = str.replace("&eacute;", u"é")
        str = str.replace("<br>", "")
        str = str.replace("<br />", "")
        str = str.replace("<a class=\"grisbleu\" href=\"", " ")
        str = str.replace("\" target=\"_blank\"><b>HTML</b></a> ou", "")
        str = str.replace("\" target=\"_blank\"><b>PDF</b>", "")
        str = str.replace("\" target=\"_blank\"><b>PDF", "")
        str = str.replace("<b>", "")
        str = str.replace("</b>", "")
        str = str.replace("<i>", "")
        str = str.replace("</i>", "")
        str = str.replace("Paru le", "</br>Paru le")
        str = str.replace("(Parution n", "<br/>(Parution n")
        return(str)
    else:
        #print("regex didn't match")
        return(0)

def showList(mylist):
    if mylist:
        print("List content:")
        for item in mylist:
            print(item)
# Execute les requetes dans la liste avec le module requests
def PostRequestIntoElasticsearch(rqtList):
    #f.write(url + '\n')
    print(url + '\n')
    for item in rqtList:
        data = json.dumps({u'Société' : item[u'Société'], u'RCS' : item[u'RCS'], u'Catégorie' : item[u'Catégorie'], u'N° d\'affaire' : item[u'_id'], \
                               u'Annonce pdf / htm': item[u'Annonce pdf / htm'], u'@timestamp': getTimeStamp(), u'Paru le' : item[u'Paru le'], u'Parution n°' : item[u'Parution n°']})
        r = requests.post(url + item[u'_id'], data)
        #print r.json()

# Execute la requete et index
def execRqt(rqt):
    r = requests.get(rqt)
    res = ParseRequest(r)
    parser = MyHTMLParser()
    if (res != 0):
        parser.feed(res)
        HtmlToJson(dataParsed)
        PostRequestIntoElasticsearch(dictJsonList)

#test url
def getUrl(url):
    rexp = re.compile('&page=((.|\n)*)&')
    res = rexp.search(url)
    #f.write('On commence la recuperation de la nouvelle entreprise à la page ' + res.group(1))
    if res.group(1) > 0:
        var = int(copy(res.group(1)))
        while var != 99:
            url = url.replace("&page=" + str(var - 1), "&page=" + str(var))
            execRqt(url)
            var += 1
    else:
        f.write('url regex didn\'t match')


getUrl("http://www.journal-officiel.gouv.fr/balo/index.php?ctx=eJwFwcENgCAMBdA*SuMC6pWbFyfw3iCpkaRQhOr8vseKq4O*ijOqgR8QVSs8LGVxCZsOt0JEyXqzHl1m7yJhOqxN4Dv7*qpiXfADk2YYKw__&page=1&SOCIETE_NAME=Alstom")
#getUrl("http://www.journal-officiel.gouv.fr/balo/index.php?ctx=eJwFwcENgCAMAMCO0rCA!nUAJ*DfFCyRBFuo4PzeUYXsQJ9C5GpAHRDVHnotFRmyR9Y!BS*B7KxJEDGZN3MesgwX2cNpLQDdZRyzVthW!AGknhuv&page=1&SOCIETE_NAME=banque%20de%20france")
getUrl("http://www.journal-officiel.gouv.fr/balo/index.php?ctx=eJwFwdENgCAMBcA3SsMC6i8DOIH*DWKJJJViRef3jhXFwV*DntTAN4iaXfxYrjIkylGIKJt38zRkGi4Sw2Y9gM861lcVy4wfQV4W6g__&page=1&SOCIETE_NAME=edf")
getUrl("http://www.journal-officiel.gouv.fr/balo/index.php?ctx=eJwFwdENgDAIBcA3CukC6q8DOIH*pDYYm2CpSJ3fO1acDv4ajqwGfkDU7ObXSpWQVUeRFkRUzLt5DpnCRda0W0*gq8Y2VLHM!AGX!RhG&page=1&SOCIETE_NAME=lucent")
f.close()
#getUrl("http://www.journal-officiel.gouv.fr/balo/index.php?ctx=eJwFwcENgDAIAEBGIV1A*TqAE*gntWIkwVIpmri9d6RwONBbYctqQDcgVruoWxEOnovzLoH6Wa1ZOiIW82aeg4dw5jmt1hLQKbE8qjCN8AOZ2BvD&page=1&SOCIETE_NAME=LCL")
