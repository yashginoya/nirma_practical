import requests
import json

def maxTransfer(name,city):
    c = ""
    d = ""
    credited = 0.0
    debited = 0.0
    apireq = requests.get('https://jsonmock.hackerrank.com/api/transactions').json()
    total_page = apireq['total_pages']
    for i in range (1,total_page):
        apireq = requests.get('https://jsonmock.hackerrank.com/api/transactions?page=' + str(i)).json()
        info = apireq['data']
        
        for it in info:
            if it['userName'] == name:
                loc = it['location']
                if loc['city'] == city:
                    s = it['amount'].replace('$','').replace(',','')
                    if it['txnType'] == 'credit':
                        if float(s) > credited:
                            credited = float(s)
                            c = it['amount']
                    if it['txnType'] == 'debit':
                        if float(s) > debited:
                            debited = float(s)
                            d = it['amount']
    return [c,d]

maxTransfer('Bob Martin','Bourg')
