import mysql.connector
import random as rand
import pickle
import random_address as ra
import pandas as pd
doctorlist=[]
# nephrologist kidney
# hepatologist liver
# ophthalmologists cornea
# Cardiovascular  heart
# Pulmonologist lung
# gastroenterologist pancreas

mydb = mysql.connector.connect(host='localhost',user='navneet',passwd='Qwerty12@',database='obds')
doc_id=[]
contact=[]
mycursor = mydb.cursor()

organisations=pd.read_csv("Bloodbankslist.csv",delimiter = ';', names=['Name'])
organisation_names=organisations['Name'].tolist()
for i in organisation_names:
	did=rand.randint(1,1000)
	if did not in doc_id:
		doc_id.append(did)
		did="BBANK_"+str(did)
		currentcontact="9"
		for j in range(0,8):
			currentcontact+=str(rand.randint(0,9))
		if currentcontact not in contact:
			contact.append(currentcontact)
			blood_Units=[];
			for k in range(8):
				blood_Units.append(rand.randint(1,50))
			address=ra.getRandomAddress()
			pincode=address[-1]
			address=address[0]+", "+address[1]+", "+address[2]
			temp=[did,i[4:],blood_Units[0],blood_Units[1],blood_Units[2],blood_Units[3],blood_Units[4],blood_Units[5],blood_Units[6],blood_Units[7],address,currentcontact,pincode]
			print(temp)
			doctorlist.append(temp)
			sql = "INSERT INTO Blood_Bank(Bank_id,Name,Apositive,Anegative,Bpositive,Bnegative,Opositive,Onegative,ABpositive,ABnegative,address,contact,pincode) VALUES (%s,%s,%s, %s,%s,%s,%s, %s,%s,%s,%s, %s,%s)"
			val = (did,i[4:],blood_Units[0],blood_Units[1],blood_Units[2],blood_Units[3],blood_Units[4],blood_Units[5],blood_Units[6],blood_Units[7],address,currentcontact,pincode)
			mycursor.execute(sql, val)
			mydb.commit()
			print(mycursor.rowcount, "record inserted.")
with open('doctor.list', 'wb') as f:
	pickle.dump(doctorlist, f)



