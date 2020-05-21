import csv, random
from country_list import countries_for_language # Son 249 países, needs conda activate

# Publisher is indexed 5
# with open("data/vgsales.csv","r") as raw_data:
#     raw_data = csv.reader(raw_data, delimiter=",")
#     header = next(raw_data)
#     print(header[5])

def isolate_publishers():
    '''
    Devuelve una lista con todos los Publishers sin repeticiones
    '''
    publishers = []
    raw_data = list(csv.reader(open("data/vgsales.csv","r"), delimiter=','))
    raw_data.pop(0)
    for reg in raw_data:
        if reg[5] not in publishers:
            publishers.append(reg[5])
    return publishers

def publishers_to_csv(publist):
    '''
    Indiza la lista de Publishers en un archivo .csv
    '''
    filewriter = csv.writer(open('data/publisher-dim.csv','w'), delimiter=',',
                                 quotechar='|', quoting=csv.QUOTE_MINIMAL)
    countries = dict(countries_for_language('en'))
    regions = ['Africa', 'Asia', 'The Caribbean', 'Central America', 'Europe', 'North America', 'Oceania', 'South America']
    index = 0
    filewriter.writerow(['id','name','country','region'])
    for element in publist:
        randcountry = countries[random.choice(list(countries.keys()))]
        index+=1
        filewriter.writerow([index, element.replace(",","-"),
                            randcountry.replace(",","-"), random.choice(regions)])

#==============================================================================#

publishers_to_csv(isolate_publishers())
