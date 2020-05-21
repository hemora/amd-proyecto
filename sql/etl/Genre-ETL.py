import csv, random

# Genre indexed 4

def isolate_genres():
    '''
    Devuelve una lista con todos los géneros sin repeticiones
    '''
    genres = []
    raw_data = list(csv.reader(open("data/vgsales.csv","r"), delimiter=','))
    raw_data.pop(0)
    for reg in raw_data:
        if reg[4] not in genres:
            genres.append(reg[4])
    return genres

def genres_to_csv(genrelist):
    '''
    Indiza la lista de géneros
    Asocia un genero con un PEGI
    '''
    filewriter = csv.writer(open('data/genres-dim.csv','w'), delimiter=',',
                                 quotechar='|', quoting=csv.QUOTE_MINIMAL)
    pegi_rate = [3,4,6,7,12,16,18]
    index = 0
    filewriter.writerow(['id','pegi','genre'])
    for element in genrelist:
        rand_pegi = random.choice(pegi_rate)
        index += 1
        filewriter.writerow([index, element, rand_pegi])

#==============================================================================#

genres_to_csv(isolate_genres())
