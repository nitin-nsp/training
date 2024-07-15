import math
from tabulate import tabulate
def out(table):
    print(tabulate(table, headers="keys",tablefmt="github"))
def add():
    nums=list(map(float,input('Enter numbers to add .... ').strip().split(' ')))
    # print(nums)1
    return sum(nums)
    # nums=input('enter ..').split(' ')
    # print(nums)
    # return 0

def subtration():
    nums=list(map(float,input('enter number to sub...').strip().split(' ')))
    ans=nums[0]
    for x in range(1,len(nums)):
         ans-=x
        
    return ans


def mul():
     nums=list(map(float,input('enter number to mul...').strip().split(' ')))
     ans=nums[0]
     for i in range(1,len(nums)):
          ans*=nums[i]
     return ans
   

def div():
     nums=list(map(float,input('enter number to div...').strip().split(' ')))
     ans=nums[0]
     for i in range(1,len(nums)):
          if nums[i]==0: 
               raise Exception(" can't divide with zero: ")
          ans/=nums[i]
         
     return ans

def sqrt():
     nums=list(map(float,input('enter number to sqrt...').strip().split(' ')))
     for i in range(len(nums)):
          nums[i]=math.sqrt(nums[i])
     return nums

def expo():
     a,b=int(input('enter a: ')),int(input('enter b: '))
     ans=a**b
     return ans


    