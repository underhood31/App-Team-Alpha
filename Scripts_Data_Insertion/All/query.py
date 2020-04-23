import mysql.connector
import names
import random as rand
import pickle

mydb = mysql.connector.connect(host='remotemysql.com',user='ED3QOAIOQK',passwd='yz51KaPFRg',database='ED3QOAIOQK')
mycursor = mydb.cursor()
sql = "select * from New_Blood_Donor;"
mycursor.execute(sql)
myresult = mycursor.fetchall()
for x in myresult:
  print(x)
mydb.commit()




