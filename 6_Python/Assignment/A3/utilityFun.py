import uuid 
import json
def addUuids():
    with open('data.json','r') as f:
        data=json.load(f)
        print(data)
    
    for item in data:
        item["book_uuid"]=str(uuid.uuid4())
    
    with open('data.json','w') as f:
        json.dump(data,f,indent=4)
        


addUuids()
