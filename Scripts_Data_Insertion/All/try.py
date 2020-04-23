import mysql.connector
import names
import random as rand

namelist=[]
# nephrologist kidney
# hepatologist liver
# ophthalmologists cornea
# Cardiovascular  heart
# Pulmonologist lung
# gastroenterologist pancreas

Docspecailty=["Nephrologist","Hepatologist","Ophthalmologists","Cardiovascular","Pulmonologist","Gastroenterologist","Others"]
organDocspeciality=["Kidney","Liver","Cornea","Heart","Lung","Pancreas","Blood"]
mydb = mysql.connector.connect(host='localhost',user='teenvan',passwd='Password@2020',database='obds')
doc_id=[]
contact=[]
mycursor = mydb.cursor()

# sql = "INSERT INTO new123 (name) VALUES (%s)"
# val = ("hello")
# mycursor.execute(sql, val)

# mydb.commit()

# print(mycursor.rowcount, "record inserted.")

for i in range(0,50):

	did=rand.randint(1,1000)
	if did not in doc_id:
		doc_id.append(did)
		# did="DOC_"+str(did)
		currentcontact="9"
		for i in range(0,8):
			currentcontact+=str(rand.randint(0,9))
		if currentcontact not in contact:
			contact.append(currentcontact)
			currentspeciality=Docspecailty[rand.randint(0,6)]
			print(did, names.get_full_name(),currentcontact,currentspeciality)

			sql = "INSERT INTO Doctor (Doc_ID, Name,Contact,Speciality) VALUES (%s, %s,%s,%s)"
			val = (did, names.get_full_name(),currentcontact,currentspeciality)
			mycursor.execute(sql, val)

			mydb.commit()

			print(mycursor.rowcount, "record inserted.")




