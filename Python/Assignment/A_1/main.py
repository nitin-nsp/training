from tabulate import tabulate
import json 

from colored import print_ascii_art,border
print_ascii_art()
with open('jsonData.json','r') as f:
    data=json.load(f)

subjects=['english','hindi','social_science','maths']
columns=['roll_no','first_name','last_name','english','hindi','social_science','maths', 'Total', 'Percentage']

def preComputation(data):
    for studentCol in data:
        total=studentCol['english']
        total+=studentCol['hindi']
        total+=studentCol['social_science']
        total+=studentCol['maths']
        studentCol['Total']=total
        studentCol['Percentage']=(total/400)*100

preComputation(data)


def out(table):
    print(tabulate(table, headers="keys",tablefmt="github"))

def out_menu(table):
    print("MENU >>>")
    out(table)

menu=[
   [1,"Print all Table","<no. of rows | default all>",""],
   [2,"Toppers","<subject wise | default overAll score >","<no. of rows | default all>"],
   [3,"Last ones","<subject wise | default overAll score >","<no. of rows | default all>"],
   [4,"SortBy","<column... | default roll_no.>"],
   [5,"Avg Marks","<subject | default overAll score>"],
   [6,"Number of records (length)"],
   [7,"Exit(-1)"]
]

def getByRank(table,sortAcc="",length=-1,order=True):
    if not sortAcc:
        sortAcc = 'Total'
    
    if(length==-1):
        length=len(table)
    sorted_table = sorted(table, key=lambda x: x[sortAcc], reverse=order)

    top_cnt=0
    
    for student in sorted_table:
        if order and student[sortAcc]<sorted_table[0][sortAcc]:
            break
        if not order and student[sortAcc]>sorted_table[0][sortAcc]:
            break
        top_cnt+=1
    

    
    top_cnt=min(top_cnt,length)

    out(sorted_table[:top_cnt])

def sortBy(table,sortAcc=['roll_no'], order=True):
    sorted_table = sorted(table, key=lambda x: tuple(x.get(acc, 0) for acc in sortAcc), reverse=order)
    out(sorted_table)

def getAvg(table,*listSubject):

    if not listSubject:
        listSubject=['Total']
    
    
def getAvg(table, OnlySubject=""):
    avgOfSubjects = {
        "english": 0,
        "hindi": 0,
        "social_science": 0,
        "maths": 0,
        "Total": 0,
        "percentage": 0
    }

    if not table:
        print("Error: No data provided.")
        return

    data_len = len(table)

    for subject in avgOfSubjects:
        total_sum = sum(row.get(subject, 0) for row in table)
        avgOfSubjects[subject] = total_sum / data_len

    if OnlySubject:
        if OnlySubject in avgOfSubjects:
            out([{OnlySubject: avgOfSubjects[OnlySubject]}])
        else:
            print(f"Error: Subject '{OnlySubject}' not found.")
    else:
        out([avgOfSubjects])




    
        



    





# out(data)
while 1:
    out_menu(menu)
    border()
    user_input=input('Enter your option: ')
    user_input=user_input.split(' ')
   

    # print(user_input)
    try:
        choice=int(user_input[0])
        if choice==-1:
            break
        if choice<1 or choice>len(menu):
            raise Exception("InvalidChoice: choose correctly from menu")
    except ValueError as ve:
            print('pls correct integer choice')
    except IndexError:
        print("Enter or choice something")
    except Exception as e:
        print(e)
        print("something went wrong choice again")
    else:
        if choice==1:
            if len(user_input)==1:
                    out(table=data)
            else:
                try:
                    noOfRows=int(user_input[1])
                    if noOfRows<1 or noOfRows> len(data):
                            raise Exception("InvalidRange: choose correct range")  
                except Exception as e:
                    print(e)
                    print("something went wrong choice again=> ")
                else:
                     out(table=data[:noOfRows])
        elif choice==2:
            if len(user_input)==1:
                    getByRank(data)
            
            try:
                subject=user_input[1]

                if subject not in subjects:
                    raise Exception("InvalidSubject: enter correct subject")
                if len(user_input)==3:
                    noOfRows=int(user_input[2])
                    
            except Exception as e:
                print(e)
            else:
                if len(user_input)==3:
                    getByRank(data,subject,noOfRows)
                else:   
                    getByRank(data,subject) 
        elif choice==3:
            if len(user_input)==1:
                    getByRank(data,order=False)
            
            try:
                subject=user_input[1]

                if subject not in subjects:
                    raise Exception("InvalidSubject: enter correct subject")
                if len(user_input)==3:
                    noOfRows=int(user_input[2])
                    
            except Exception as e:
                print(e)
            else:
                if len(user_input)==3:
                    getByRank(data,subject,noOfRows, order=False)
                else:   
                    getByRank(data,subject,order=False)  
        elif choice==4:
            try:
                if len(user_input)==1:
                    sortBy(table=data)
                userSubjects=user_input[1:]
                for subject in userSubjects:
                    if subject not in subjects:
                        raise Exception("InvalidSubject: enter correct subject")
            except Exception as e:
                print(e)
            else:
                sortBy(data,userSubjects,order=False)
        elif choice==5:
            try:
                if len(user_input) == 1:
                    getAvg(data)
                # else:
                subject = user_input[1]
                if subject not in subjects:
                    raise Exception("InvalidSubject: Enter correct subject")
            except Exception as e:
                print("Error:", e)
            else:
                getAvg(data, subject)
                
                
        elif choice==6:
            out([{'no_of_records' :len(data)}])
        
      
        border()
        ipt=input('Enter any key for menu or -1 to exit: ')
        if ipt=='-1':
            break
        

    
   


            
            
        
              

            
                    

                



            
            
        

            


   



   



# out(data)







