import random
inpbbit=""
inpabit=""
d=""
inpa=0
inpb=0
l=""
length = 10
Fobj=open(r"C:\Users\kakhi\OneDrive\Desktop\IITB\Dadda_Mult_10x12bits\inp.txt",'w')
for i in range(64):
    for j in range(length):
        a= random.randint(0,1)
        inpa+=(a)*(2**((length - 1)-j))
        inpabit+= str(a)
        
        c=random.randint(0,1)
        inpb+=(c)*(2**((length - 1)-j))
        inpbbit+=str(c)

        #cin=random.randint(0,1)
        #cin=0
        
    outsum= inpa * inpb #+ cin
    h=outsum
    for k in range(length + length): #number of bits in the output to be specified in the bracket
        i=h%2
        l+=str(i)
        h=h//2
    outsumbit = l [::-1]
    print(outsumbit,inpabit,inpbbit,outsum)
    temp=outsumbit+inpabit+inpbbit+'\n'
    Fobj.write(temp)
    inpabit=""
    inpbbit=""
    l=""
    inpa=0
    inpb=0
Fobj.close()
