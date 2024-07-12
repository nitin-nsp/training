# class Colors:
#     RED = '\033[91m'
#     GREEN = '\033[92m'
#     YELLOW = '\033[93m'
#     BLUE = '\033[94m'
#     MAGENTA = '\033[95m'
#     CYAN = '\033[96m'
#     WHITE = '\033[97m'
#     RESET = '\033[0m'

# studnet = """******************************************
# *  ____  _             _            _    *
# * / ___|| |_ _   _  __| | ___ _ __ | |_  *
# * \___ \| __| | | |/ _` |/ _ \ '_ \| __| *
# *  ___) | |_| |_| | (_| |  __/ | | | |_  *
# * |____/ \__|\__,_|\__,_|\___|_| |_|\__| *
# ******************************************"""
# record = """*************************************
# * ____                        _     *
# *|  _ \ ___  ___ ___  _ __ __| |___ *
# *| |_) / _ \/ __/ _ \| '__/ _` / __|*
# *|  _ |  __| (_| (_) | | | (_| \__ \*
# *|_| \_\___|\___\___/|_|  \__,_|___/*
# *************************************"""

# # Print both strings in the same line with different colors
# print(Colors.RED + studnet + Colors.RESET + Colors.GREEN + record + Colors.RESET)

def print_ascii_art():
    student_line = "*  ____  _             _            _     ____                        _  *"
    record_line = "* / ___|| |_ _   _  __| | ___ _ __ | |_  |  _ \ ___  ___ ___  _ __ __| | *"
    record_line2 = "* \___ \| __| | | |/ _` |/ _ \ '_ \| __| | |_) / _ \/ __/ _ \| '__/ _` | *"
    student_line2 = "*  ___) | |_| |_| | (_| |  __/ | | | |_  |  _ <  __/ (_| (_) | | | (_| | *"
    bottom_line = "* |____/ \__|\__,_|\__,_|\___|_| |_|\__| |_| \_\___|\___\___/|_|  \__,_| *"

    # Print the ASCII art with color codes for "student" and "record"
    border="**************************************************************************"
    print(f"\033[92m{border}\033[0m")
    print(f"\033[91m{student_line}\033[0m")
    print(f"\033[91m{record_line}\033[0m")
    print(f"\033[91m{record_line2}\033[0m")
    print(f"\033[91m{student_line2}\033[0m")
    print(f"\033[91m{bottom_line}\033[0m")
    print(f"\033[92m{border}\033[0m")
    

def border():
    border="**************************************************************************"
    print(f"\033[92m{border}\033[0m")

# Call the function to print the ASCII art
# print_ascii_art()
