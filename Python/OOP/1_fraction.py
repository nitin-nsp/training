class Fraction:
    def __init__(self,n,d) -> None:
        self.n=n
        self.d=d
    def __str__(self) -> str:
        return f"{self.n}/{self.d}"
    def __add__(self, other):
 
        return Fraction(self.n+other.n,self.d+other.d)
    


f1=Fraction(4,5)
print(f1)
f2=Fraction(4,5)
f3=f1+f2

print(f3)