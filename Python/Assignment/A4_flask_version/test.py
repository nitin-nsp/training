from controllers.book import *



def deleteById(id):
    id = str(id)
    
    with open('data.json', 'r') as f:
        data = json.load(f)
    
    print(data)
    isDel=False    
    for i in range(len(data)):
        if   data[i]["book_uuid"]==id:
             data.pop(i)
             isDel=True
    

    print(isDel,data)
    with open('data.json','w') as f:
            json.dump(data,f,indent=4)

    return data
    
deleteById('a22639f7-9315-4c2b-9e34-565f75dfa9d3')