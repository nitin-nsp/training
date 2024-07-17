import json
def getAllData():
    with open('data.json','r') as f:
        data=json.load(f)
    
    return data

def updateData(id, columnsToUpdate):
    id = str(id)
    found = False
    
    with open('data.json', 'r+') as f:
        data = json.load(f)
        
        for item in data:
            if item["book_uuid"] == id:
                for column, val in columnsToUpdate.items():
                    item[column] = val
                found = True
        
        if found:
            
            f.seek(0)  # Move the file pointer to the beginning of the file
            json.dump(data, f, indent=4)  # Write the updated data
            f.truncate()  # Truncate any remaining content (in case the new data is shorter)
            return "updated successfully"
    
    return "notFound"
            
            
           
    
    


def getById(id):
    id=str(id)
    with open('data.json','r') as f:
        data=json.load(f)
    
    try:
        item=data[id]
    except Exception as e:
        print(e)
    else:
        return item

def deleteById(id):
    id=str(id)
    with open('data.json','r+') as f:
        data=json.load(f)

    for item in data:
        try:
            del item[id]
        except Exception as e:
            print('NotExists: ',e)
    
    json.dump(data,f)

def createItem(Book):
    with open('data.json','r+') as f:
        try:
            data=json.load(f)
        except Exception as e:
            data=[]
        else:
            data.append(Book)
        

            

    data.append(Book)

    json.dump(data,f)

