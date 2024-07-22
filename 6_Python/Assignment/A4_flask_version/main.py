from flask import Flask,request
from flask_restful import Resource, Api
import json
from controllers.book import *
app=Flask(__name__)
api=Api(app)

class Items(Resource):
    def get(self):
        return getAllData()
    
    #create
    def post(self):
        data=request.json
        return createItem(data)


class Item(Resource):
    def get(self,b_Id):
        return getById(b_Id)
    

    def put(self,b_Id):
        data=request.json
        return updateData(b_Id,data)
        #  update 
    def delete(self,b_Id):
        return deleteById(b_Id)

       
api.add_resource(Items, '/')
api.add_resource(Item, '/<uuid:b_Id>')

# @app.route('/')
# def hello():
#     return '<h1> hello </h1>'



if __name__=='__main__':
    app.run(debug=True)