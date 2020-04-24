import mysql.connector
import names
import random as rand
import pickle
import random
import time
import faker


ld=open("doctor.list","rb")
doctorlist=pickle.load(ld)
patientlist=[]
Docspecailty=["Nephrologist","Hepatologist","Ophthalmologists","Cardiovascular","Pulmonologist","Gastroenterologist"]
organDocspeciality=["Kidney","Liver","Cornea","Heart","Lung","Pancreas"]
Bloodgroup=["A+","A-","B+","B-","AB+","AB-","O+"]

doctororgan=[]
Kidney=[]
Liver=[]
Cornea=[]
Heart=[]
Lung=[]
Pancreas=[]
ld=open("organizations.list","rb")
organizationslist=pickle.load(ld);
#print(organizationslist)
for i in doctorlist:
	#print(i[3])
	if i[3]=="Nephrologist":
		Kidney.append(i)
	elif i[3]=="Hepatologist":
		Liver.append(i)
	elif i[3]=="Ophthalmologists":
		Cornea.append(i)
	elif i[3]=="Cardiovascular":
		Heart.append(i)
	elif i[3]=="Pulmonologist":
		Lung.append(i)
	elif i[3]=="Gastroenterologist":
		Pancreas.append(i)
doctororgan=[Kidney,Liver,Cornea,Heart,Lung,Pancreas]


#print(Kidney)
#print(Kidney)
#print(Liver)
#print(Cornea)
#print(Heart)
#print(Lung)
#print(Pancreas)



addresslist=[]


# nephrologist kidney
# hepatologist liver
# ophthalmologists cornea
# Cardiovascular  heart
# Pulmonologist lung
# gastroenterologist pancreas

#Put PinAndStates.list and this script in same folder and run it
#2D list of the form-->  [[Pin, State],....]
def getRandomAddress():
	f=faker.Faker()
	ld=open("PinAndStates.list","rb")
	obk=pickle.load(ld)
	random.shuffle(obk)

	hno=f.address()
	n=hno.find("\n")
	hno=hno[:n]
	hno.replace("\n"," ")
	city=obk[0][1]
	state=obk[0][2]
	pincode=obk[0][0]
	return [hno,city,state,pincode]



#print(getRandomAddress())
# print(obk)



def str_time_prop(start, end, format, prop):
	stime = time.mktime(time.strptime(start, format))
	etime = time.mktime(time.strptime(end, format))
	ptime = stime + prop * (etime - stime)
	return time.strftime(format, time.localtime(ptime))


def random_date(start, end, prop):
	return str_time_prop(start, end, '%Y-%m-%d', prop)




mydb = mysql.connector.connect(host='localhost',user='navneet',passwd='Qwerty12@',database='obds')
pat_id=[]
contact=[]
mycursor = mydb.cursor()


for i in range(0,500):

	patid=rand.randint(1,1000)
	if patid not in pat_id:
		pat_id.append(patid)
		patid="BLD_"+str(patid)
		currentcontact="7"
		for j in range(0,9):
			currentcontact+=str(rand.randint(0,9))
		if currentcontact not in contact:
			contact.append(currentcontact)
			# currentspeciality=Docspecailty[rand.randint(0,6)]
			
			date=random_date("2019-1-1", "2020-1-1", random.random())
			#print(date)
			address=getRandomAddress()
			if(address not in addresslist):
				addresslist.append(address)
				organindex=rand.randint(0,5)
				organ=organDocspeciality[organindex]
				maxlistindex=len(doctororgan[organindex])
				Doc_id=doctororgan[organindex][rand.randint(0,maxlistindex-1)][0]
				org_id=organizationslist[rand.randint(0,len(organizationslist)-1)][0]
				Blood_Group=Bloodgroup[rand.randint(0,6)]
				Age=rand.randint(18,70)
				#pprint(address[-1], date , patid , names.get_full_name() , currentcontact , address[0]+" "+address[1]+" "+address[2] , Doc_id , organ , Age , Blood_Group)
				#temp=[address[-1], date , patid , names.get_full_name() , currentcontact , address[0]+" "+address[1]+" "+address[2] , Doc_id , organ , Age , Blood_Group]
				#patientlist.append(temp);
				# print(Age, patid,names.get_full_name() , address[0]+" "+address[1]+" "+address[2] , currentcontact ,org_id ,"Alive",date  ,  Blood_Group,address[-1])
				sql = "INSERT INTO  Blood_Donor(Age,BLD_ID,Name,Address,ORG_id,Blood_Group,Last_donated,Last_checkup,Pincode,Contact) VALUES(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)"
				val=  (Age, patid,names.get_full_name() , address[0]+" "+address[1]+" "+address[2]  ,org_id ,  Blood_Group,date,date,address[-1],currentcontact)
				# print(val)
				mycursor.execute(sql, val)

				mydb.commit()

				#print(mycursor.rowcount, "record inserted.")


