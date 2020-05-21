import csv, random

# Platform is indexed 2

def isolate_platforms():
    '''
    Devuelve una lista con todas las plataformas sin repeticiones
    '''
    platforms = []
    raw_data = list(csv.reader(open("data/vgsales.csv","r"), delimiter=','))
    raw_data.pop(0)
    for reg in raw_data:
        if reg[2] not in platforms:
            platforms.append(reg[2])
    return platforms

def platform_to_csv(publist):
    '''
    Indiza la lista de plataformas
    Asocia una consola con una generación
    '''
    filewriter = csv.writer(open('data/platform-dim.csv','w'), delimiter=',',
                                 quotechar='|', quoting=csv.QUOTE_MINIMAL)
    console_gens = [1,2,3,4,5,6,7,8]
    index = 0
    filewriter.writerow(['id','generation','platform'])
    for element in publist:
        rand_gen = random.choice(console_gens)
        index+=1
        filewriter.writerow([index, element, rand_gen])

#==============================================================================#

platform_to_csv(isolate_platforms())
