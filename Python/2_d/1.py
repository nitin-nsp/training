# a=[1,2,3,4,5,6,7,8,9,10]

# print(a[-1::-1])
# print(a[::-1])

# challenge = '123'
# print(challenge.isdecimal())  # True

# Define a variable
x = 5

# Create a string with the superscript two character
output = f"x\u00B2 = {x}\u00B2"

# Print the result
print(output)

str='Coding For All string'.split(' ')
print(str,str[0])

str="Facebook, Google, Microsoft, Apple, IBM, Oracle, Amazon".split('e, ')
print(str)

# ANSI color codes
class Colors:
    RED = '\033[91m'
    GREEN = '\033[92m'
    YELLOW = '\033[93m'
    BLUE = '\033[94m'
    MAGENTA = '\033[95m'
    CYAN = '\033[96m'
    WHITE = '\033[97m'
    RESET = '\033[0m'  # Reset to default color

# Example usage
print(Colors.RED + "This is red text!" + Colors.RESET)