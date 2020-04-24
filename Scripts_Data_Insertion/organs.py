import pickle
import random
import secrets
import mysql.connector
from randomtimestamp import randomtimestamp

def load_list(name):
	pickle_in=open(name,"rb")
	lis = pickle.load(pickle_in)
	# pickle_in.close()
	return lis
def randomts(year):
	ts=randomtimestamp(year)
	t=ts.split(" ")[1]
	d=ts.split(" ")[0]
	d=d.split("-")
	d=d[2]+"-"+d[1]+"-"+d[0]
	ts=d+" "+t
	return ts


def kidney(donorlist, patientlist, mycursor):
	all_data=[]
	donor_patient_id=[]
	donor_id=[]
	patient_id=[]
	# remove all the donors of differednt organs and add to donor_id
	# remove all the patients of different organs and add to patient_id
	for x in donorlist:
		if x[1]=="Kidney":
			donor_id.append(x[0])
	for x in patientlist:
		if x[0]=="Kidney":
			patient_id.append(x[3])
	for i in patient_id:
		donor_patient_id.append(("NULL",i))
	for i in donor_id:
		donor_patient_id.append((i,"NULL"))

	f=0
	for x in donor_patient_id:
		f+=1
		ORGAN_id = "KD" + str(f).zfill(6)
		DON_id = x[0]
		PAT_id = x[1]
		Matched_id = "NULL"
		PRA = random.randint(0,99)
		if DON_id=="NULL":
			sql = "INSERT INTO Kidney (ORGAN_id, PAT_id, PRA) VALUES (%s, %s,%s)"
			this_tupple = (ORGAN_id,PAT_id,PRA)	
		else:
			sql = "INSERT INTO Kidney (ORGAN_id, DON_id, PRA) VALUES (%s, %s,%s)"
			this_tupple = (ORGAN_id,DON_id,PRA)	
		mycursor.execute(sql, this_tupple)
		mydb.commit()
		print(mycursor.rowcount, "record inserted.")

		all_data.append(this_tupple)
	# print(all_data)	

def pancreas(donorlist, patientlist, mycursor):
	all_data=[]
	donor_patient_id=[]
	donor_id=[]
	patient_id=[]
	# remove all the donors of differednt organs and add to donor_id
	# remove all the patients of different organs and add to patient_id
	for x in donorlist:
		if x[1]=="Pancreas":
			donor_id.append(x[0])
	for x in patientlist:
		if x[0]=="Pancreas":
			patient_id.append(x[3])
	for i in patient_id:
		donor_patient_id.append(("NULL",i))
	for i in donor_id:
		donor_patient_id.append((i,"NULL"))

	f=0
	for x in donor_patient_id :
		f+=1
		ORGAN_id = "PN" + str(f).zfill(6)
		DON_id = x[0]
		PAT_id = x[1]
		Matched_id = "NULL"
		OPTN = random.uniform(10,14.5)
		if DON_id=="NULL":
			sql = "INSERT INTO Pancreas (ORGAN_id, PAT_id, OPTN) VALUES (%s, %s,%s)"
			this_tupple = (ORGAN_id,PAT_id,OPTN)	
		else:
			sql = "INSERT INTO Pancreas (ORGAN_id, DON_id, OPTN) VALUES (%s, %s,%s)"
			this_tupple = (ORGAN_id,DON_id,OPTN)	
		mycursor.execute(sql, this_tupple)
		mydb.commit()
		print(mycursor.rowcount, "record inserted.")
		all_data.append(this_tupple)
	# print(all_data)	

def heart(donorlist, patientlist, mycursor):
	all_data=[]
	donor_patient_id=[]
	donor_id=[]
	patient_id=[]
	# remove all the donors of differednt organs and add to donor_id
	# remove all the patients of different organs and add to patient_id
	for x in donorlist:
		if x[1]=="Heart":
			donor_id.append(x[0])
	for x in patientlist:
		if x[0]=="Heart":
			patient_id.append(x[3])

	for i in patient_id:
		donor_patient_id.append(("NULL",i))
	for i in donor_id:
		donor_patient_id.append((i,"NULL"))


	f=0
	for x in donor_patient_id:
		f+=1
		ORGAN_id = "H" + str(f).zfill(6)
		DON_id = x[0]
		PAT_id = x[1]
		Matched_id = "NULL"
		Weight = random.uniform(200,400)
		if DON_id=="NULL":
			sql = "INSERT INTO Heart (ORGAN_id, PAT_id, Weight) VALUES (%s, %s,%s)"
			this_tupple = (ORGAN_id,PAT_id,Weight)	
		else:
			sql = "INSERT INTO Heart (ORGAN_id, DON_id, Weight) VALUES (%s, %s,%s)"
			this_tupple = (ORGAN_id,DON_id,Weight)	

		
		mycursor.execute(sql, this_tupple)
		mydb.commit()
		print(mycursor.rowcount, "record inserted.")
		all_data.append(this_tupple)
	# print(all_data)	

def lung(donorlist, patientlist, mycursor):
	all_data=[]
	donor_patient_id=[]
	donor_id=[]
	patient_id=[]
	# remove all the donors of differednt organs and add to donor_id
	# remove all the patients of different organs and add to patient_id
	for x in donorlist:
		if x[1]=="Lung":
			donor_id.append(x[0])
	for x in patientlist:
		if x[0]=="Lung":
			patient_id.append(x[3])
	for i in patient_id:
		donor_patient_id.append(("NULL",i))
	for i in donor_id:
		donor_patient_id.append((i,"NULL"))

	f=0
	for x in donor_patient_id:
		f+=1
		ORGAN_id = "LU" + str(f).zfill(6)
		DON_id = x[0]
		PAT_id = x[1]
		Matched_id = "NULL"
		Age = random.randint(20,50)
		Size = random.randint(3000,5000)
		Smoking = random.randint(0,10)
		if DON_id=="NULL":
			sql = "INSERT INTO Lung (ORGAN_id, PAT_id, Age, Size, Smoking_History) VALUES (%s, %s,%s, %s, %s)"
			this_tupple = (ORGAN_id,PAT_id,Age,Size,Smoking)	
		else:
			sql = "INSERT INTO Lung (ORGAN_id, DON_id, Age, Size, Smoking_History) VALUES (%s, %s,%s, %s, %s)"
			this_tupple = (ORGAN_id,DON_id,Age,Size,Smoking)	

		mycursor.execute(sql, this_tupple)
		mydb.commit()
		print(mycursor.rowcount, "record inserted.")
		all_data.append(this_tupple)
	# print(all_data)	

def liver(donorlist, patientlist, mycursor):
	# print("here")

	all_data=[]
	donor_patient_id=[]
	donor_id=[]
	patient_id=[]
	# remove all the donors of differednt organs and add to donor_id
	# remove all the patients of different organs and add to patient_id

	for x in donorlist:
		if x[1]=="Liver":
			donor_id.append(x[0])
	for x in patientlist:
		if x[0]=="Liver":
			patient_id.append(x[3])
	for i in patient_id:
		donor_patient_id.append(("NULL",i))
	for i in donor_id:
		donor_patient_id.append((i,"NULL"))

	f=0
	for x in donor_patient_id:
		f+=1
		ORGAN_id = "LI" + str(f).zfill(6)
		DON_id = x[0]
		PAT_id = x[1]
		Matched_id = "NULL"
		Weight = random.uniform(1300,1550)
		if DON_id=="NULL":
			sql = "INSERT INTO Liver (ORGAN_id, PAT_id, Weight) VALUES (%s, %s,%s)"
			this_tupple = (ORGAN_id,PAT_id,Weight)	
		else:
			sql = "INSERT INTO Liver (ORGAN_id, DON_id, Weight) VALUES (%s, %s,%s)"
			this_tupple = (ORGAN_id,DON_id,Weight)	

		mycursor.execute(sql, this_tupple)
		mydb.commit()
		print(mycursor.rowcount, "record inserted.")
		all_data.append(this_tupple)
	# print(all_data)	

def cornea(donorlist, patientlist, mycursor):
	all_data=[]
	donor_patient_id=[]
	donor_id=[]
	patient_id=[]
	# remove all the donors of differednt organs and add to donor_id
	# remove all the patients of different organs and add to patient_id
	for x in donorlist:
		if x[1]=="Cornea":
			donor_id.append(x[0])
	for x in patientlist:
		if x[0]=="Cornea":
			patient_id.append(x[3])
	for i in patient_id:
		donor_patient_id.append(("NULL",i))
	for i in donor_id:
		donor_patient_id.append((i,"NULL"))

	f=0
	for x in donor_patient_id:
		f+=1
		ORGAN_id = "C" + str(f).zfill(6)
		DON_id = x[0]
		PAT_id = x[1]
		Matched_id = "NULL"
		time="NULL"
		if random.randint(0,1)==1 or PAT_id!="NULL":
			time=str(randomts(2020))
			if DON_id=="NULL":
				sql = "INSERT INTO Cornea (ORGAN_id, PAT_id) VALUES (%s, %s)"
				this_tupple = (ORGAN_id,PAT_id)	
			else:
				sql = "INSERT INTO Cornea (ORGAN_id, DON_id, Procurement_Timestamp) VALUES (%s, %s,%s)"
				this_tupple = (ORGAN_id,DON_id,time)
		else:
			if DON_id=="NULL":
				sql = "INSERT INTO Cornea (ORGAN_id, PAT_id) VALUES (%s, %s)"
				this_tupple = (ORGAN_id,PAT_id)	
			else:
				sql = "INSERT INTO Cornea (ORGAN_id, DON_id) VALUES (%s, %s)"
				this_tupple = (ORGAN_id,DON_id)

		mycursor.execute(sql, this_tupple)
		mydb.commit()
		print(mycursor.rowcount, "record inserted.")
		all_data.append(this_tupple)
	# print(all_data)	


if __name__ == '__main__':
	donorlist = load_list("organdonor.list")
	patientlist = load_list("patient.list")
	mydb = mysql.connector.connect(host='localhost',user='navneet',passwd='Qwerty12@',database='obds')
	mycursor = mydb.cursor()
	# print(randomts(2020))
	# kidney(donorlist,patientlist,mycursor)
	# pancreas(donorlist,patientlist,mycursorone)
	# heart(donorlist,patientlist,mycursor)
	# lung(donorlist,patientlist,mycursor)
	# liver(donorlist,patientlist,mycursor)
	cornea(donorlist,patientlist,mycursor)
		
	# kidney(donorlist,patientlist,None)
	# pancreas(donorlist,patientlist,None)
	# heart(donorlist,patientlist,None)
	# lung(donorlist,patientlist,None)
	# liver(donorlist,patientlist,None)
	# cornea(donorlist,patientlist,None)