#file1 = open("Lista_aptos_mexico.txt","r")
#file2 = open("Lista_aptos_mexico.txt","r")
import random
import time

def strTimeProp(start, end, format, prop):

    stime = time.mktime(time.strptime(start, format))
    etime = time.mktime(time.strptime(end, format))

    ptime = stime + prop * (etime - stime)

    return time.strftime(format, time.localtime(ptime))


def randomDate(start, end, prop):
    return strTimeProp(start, end, '%d/%m/%Y', prop)

output = open("crossed_data.txt","w")

array1 = []
array2 = []
array3=[]
with open('Lista_aptos_mexico.txt') as my_file:
    for line in my_file:
        array1.append(line.split(" ")[0])
        array2.append(line.split(" ")[0])

with open("dest_int.txt") as file:
	for n in file:
			array3.append(n.split(" ")[0])

for i in array1:
	for j in array2:
		if (i != j):
			output.write(i+" "+j+" "+randomDate("1/06/2018","31/12/2018",random.random())+"\n") 

for k in array1:
	for l in array3:
		if (k == "MEX" or k=="GDL" or k=="MTY" or k=="CUN"):
			output.write(k+" "+l+" "+randomDate("1/06/2018","31/12/2018",random.random())+"\n")

output.close()
