import mysql.connector
import names
import random as rand
import faker
import pickle
def getRandomAddress():
	f=faker.Faker()
	ld=open("PinAndStates.list","rb")
	obk=pickle.load(ld)
	rand.shuffle(obk)
	hno=f.address()
	n=hno.find("\n")
	hno=hno[:n]
	hno.replace("\n"," ")
	city=obk[0][1]
	state=obk[0][2]
	pincode=obk[0][0]
	return str(hno)+" "+str(city)+" "+str(state)+" "+str(pincode)  

mydb = mysql.connector.connect(host='localhost',user='navneet',passwd='Qwerty12@',database='obds')
names=["Donate Life","The charity for organ Donation","National Transplant Assistace","United Network of Organ Sharing","Scientific Registry of Transplant reciptants","National Organ & Tissue Transplant Organisation","Mohan Foundation","Indiana Donor Network","Kerala Network for Organ Sharing","Donation and Transplantation Institute","faith organizations","Mahatma Gandhi Organ Donation","The Eye-Bank","New-Eye","Donate life","Blood center","Community organ Network","Lifeshare","New Donor Servies","Center for Organ recovery","Gift of hope","LifeGift","Gift of Life","Donate life","National Kidney Foundation","Organ Donor Register","Eye Bank","National Society of Transplantation","National Transplant Organisation","Indian Kidney fund","Liver Foundation","Association of organ bank","Transplant Alliance","Donor Network","LifeNet health","Lifeline","Society of Transplant","Living Bank","Help Hope Live","Lifecenter","Lifeshares","Lifesource","Donor Service","Donor Life","Center for Donation and Transplant","NHS Blood and Transplant"]
doc_id=[]
contact=[]
mycursor = mydb.cursor()
organisationlist=[]
for i in range(0,45):
	did=rand.randint(1,1000)
	if did not in doc_id:
		doc_id.append(did)
		did="ORG_"+str(did)
		currentcontact="6"
		for i in range(0,8):
			currentcontact+=str(rand.randint(0,9))
		if currentcontact not in contact:
			contact.append(currentcontact)
			index=rand.randint(0,len(names)-1)
			n=names[index]
			a=getRandomAddress()
			del names[index]
			sql = "INSERT INTO Organisation (ORG_id, Name, Address, Contact ) VALUES (%s, %s,%s,%s)"
			val = (did, n,a,currentcontact)
			mycursor.execute(sql, val)
			organs=["Kidney","Liver","Cornea","Heart","Lung","Pancreas"]
			x=rand.randint(1,5)
			i=0
			temp=[]
			while i<=x:
				selected=organs[rand.randint(0,5)]
				if(selected in temp):
					continue
				else:
					i+=1
					temp.append(selected)
					sql = "INSERT INTO Organisation_Org_Accepted (ORG_id, organ) VALUES (%s, %s)"
					val = (did,selected)
					temp2=[did,selected]
					organisationlist.append(temp2);
					mycursor.execute(sql, val)
			mydb.commit()

			print(mycursor.rowcount, "record inserted.")
with open('organizations.list', 'wb') as f:
	pickle.dump(organisationlist, f)
organs=["Kidney","Liver","Cornea","Heart","Lung","Pancreas","Blood"]

# x=rand.randint(0,6)
# i=0
# temp=[]
# while i<=x:
# 	selected=organs[rand.randint(0,6)]
# 	if(selected in temp):
# 		continue
# 	else:
# 		i+=1
# 		temp.append(selected)
# print(temp)
