from tabulate import tabulate

def preComputation(data):
    for studentCol in data:
        total=studentCol['english']
        total+=studentCol['hindi']
        total+=studentCol['social_science']
        total+=studentCol['maths']
        studentCol['Total']=total
        studentCol['Percentage']=(total/400)*100




def out(table):
    print(tabulate(table, headers="keys",tablefmt="github"))

def out_menu(table):
    print("MENU >>>")
    out(table)


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




    
        
