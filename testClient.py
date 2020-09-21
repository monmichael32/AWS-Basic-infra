from pymongo import MongoClient
from pymongo.errors import ConnectionFailure
client = MongoClient ("3.236.202.254")
try:
   # The ismaster command is cheap and does not require auth.
   client.admin.command('ismaster')
except ConnectionFailure:
   print("Server not available")

mydatabase = client.mongodb_one
students = [ {'name': 'Billy', 'ID': 52642},
    {'name': 'Bob', 'ID': 57127},
    {'name': 'Joe', 'ID': 9000},
    {'name': 'Yohoho', 'ID': 29000},
    {'name': 'Ben', 'ID': 350000},
    {'name': 'Charlotte', 'ID': 21000},
    {'name': 'Humphrey', 'ID': 41400},
    {'name': 'Beans', 'ID': 21600} ]
mydatabase = client.test
mydatabase.students.insert_many(students)
collections = mydatabase.list_collection_names()
print(collections)
~                                   
