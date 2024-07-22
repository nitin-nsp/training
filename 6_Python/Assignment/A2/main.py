from  utility_fun import *

menu=[
   [1,"for ADD ... "],
   [2,"for Sub..."],
   [3,"for Multiply... "],
   [4,"for Div... "],
   [5,"for Sqrt... "],
   [6,"for exp..."],
   [-1, "Exit "]
]

while 1:
    out(menu)

    try:
        choice=int(input('select operation... : '))
        if(choice==-1):
            break
    except Exception as e:
        print(e)
    else:
        if choice==1:
            try:
                ans=add()
            except Exception as e:
                print(e)
            else:
                print('Result: ' ,ans)
        elif choice==2:
            try:
                ans=subtration()
            except Exception as e:
                print(e)
            else:
                print('Result: ', ans)
        elif choice==3:
            try:
                ans=mul()
            except Exception as e:
                print(e)
            else:
                print('Result: ' ,ans)
        elif choice==4:
            try:
                ans=div()
            except Exception as e:
                print(e)
            else:
                print('Result: ' ,ans)
        elif choice==5:
            try:
                ans=sqrt()
            except Exception as e:
                print(e)
            else:
                print('Result: ' ,ans)
        elif choice==6:
            try:
                ans=expo()
            except Exception as e:
                print(e)
            else:
                print('Result: ' ,ans)
        else: 
            print(' pls select correct input: ')

        



