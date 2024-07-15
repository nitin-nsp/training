from tabulate import tabulate
import json 

from A_1.colored_board import print_ascii_art,border
from utilityFun import *
from global_var import *

print_ascii_art()


with open('jsonData.json','r') as f:
    data=json.load(f)
while 1:
    out_menu(menu)
    border()
    user_input=input('Enter your option: ')
    user_input=user_input.split(' ')
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







