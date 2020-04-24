#Put PinAndStates.list and this script in same folder and run it
#2D list of the form-->  [[Pin, State],....]


import pickle
ld=open("PinAndStates.list","rb")
obk=pickle.load(ld)
for i in obk:
	# if(i[1]!='PUNJAB'):
	print(i)
# print(obk)