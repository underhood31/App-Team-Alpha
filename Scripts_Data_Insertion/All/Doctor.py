import mysql.connector
import names
import random as rand
import pickle

def doctor():
	doctorlist=[]
	# nephrologist kidney
	# hepatologist liver
	# ophthalmologists cornea
	# Cardiovascular  heart
	# Pulmonologist lung
	# gastroenterologist pancreas

	Docspecailty=["Nephrologist","Hepatologist","Ophthalmologists","Cardiovascular","Pulmonologist","Gastroenterologist","Others"]
	organDocspeciality=["Kidney","Liver","Cornea","Heart","Lung","Pancreas","Blood"]
	mydb = mysql.connector.connect(host='localhost',user='navneet',passwd='Qwerty12@',database='obds')
	doc_id=[]
	contact=[]
	mycursor = mydb.cursor()


	for i in range(0,1000):
		print(i)
		did=rand.randint(1,100000)
		if did not in doc_id:
			doc_id.append(did)
			did="DOC_"+str(did)
			currentcontact="9"
			for i in range(0,9):
				currentcontact+=str(rand.randint(0,9))
			if currentcontact not in contact:
				contact.append(currentcontact)
				currentspeciality=Docspecailty[rand.randint(0,6)]
				name=names.get_full_name()
				if(len(name)<20):
					temp=[did,  "Dr. "+name,currentcontact,currentspeciality]
					# print(did,"Dr."+  name,currentcontact,currentspeciality)
					doctorlist.append(temp)
					sql = "INSERT INTO Doctor (Doc_ID, Name,Contact,Speciality) VALUES (%s, %s,%s,%s)"
					val = (did, names.get_full_name(),currentcontact,currentspeciality)
					mycursor.execute(sql, val)
					mydb.commit()
					# print(mycursor.rowcount, "record inserted.")
	with open('doctor.list', 'wb') as f:
		pickle.dump(doctorlist, f)

if __name__ == '__main__':
	doctor()