import json
import uuid 
def getAllData():
    with open('data.json','r') as f:
        data=json.load(f)
    
    return data



def getById(id):
    id=str(id)
    with open('data.json','r') as f:
        data=json.load(f)
    
    try:
        for item in data:
            if item["book_uuid"]==id:
                return item
    except Exception as e:
        print(e)
    

def updateData(id, columnsToUpdate):
    id = str(id)
    found = False
    
    with open('data.json', 'r') as f:
        data = json.load(f)
        
    
   
    for item in data:
        if item["book_uuid"] == id:
            for column, val in columnsToUpdate.items():
                    item[column] = val
        
    with open('data.json','w') as f:
        json.dump(data,f,indent=4)
    
    return data
        
    


def deleteById(id):
    id = str(id)
    
    with open('data.json', 'r') as f:
        data = json.load(f)
    
    print(data)
    isDel=False    
    for i in range(len(data)):
        if "book_uuid" in data[i] and  data[i]["book_uuid"]==id:
             del data[i]
             isDel=True

    print(isDel)
    with open('data.json','w') as f:
            json.dump(data,f,indent=4)

    return data
          
def createItem(Book):
    with open('data.json','r') as f:
        data=json.load(f)

    Book["book_uuid"]=str(uuid.uuid4())
    data.append(Book)

    with open('data.json','w') as f:
        json.dump(data,f,indent=4)
    
    return data
   