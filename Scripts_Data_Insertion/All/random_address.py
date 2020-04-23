#Put PinAndStates.list and this script in same folder and run it
#2D list of the form-->  [[Pin, State],....]
import random
import faker
import pickle


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


print(getRandomAddress())
# print(obk)


