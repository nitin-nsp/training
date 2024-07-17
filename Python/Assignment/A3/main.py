from controllers.book import *


# to get Data
# print(getAllData())

# to update 
u_id="a22639f7-9315-4c2b-9e34-565f75dfa9d3"
updateDict={
    "bookName": "coders",
        "authorName": "nitin singh",
        "price": "Franc",
        "rating": 4,
}
res=updateData(u_id,updateDict)


