import random
import math
 
GeneratedSeq = ''
SeqUrn = []
ProbUrn = [0.6, 0.3, 0.1]
ProbSwitch = [[0.7, 0.2, 0.1], [0.3, 0.5, 0.2], [0.3, 0.3, 0.4]]
DistUrn = [[70, 20, 10], [50, 20, 30], [40, 40, 20]]
ReqSeq = 'RRGGB'
 
#Selecting the starting urn
def startUrn(ProbUrn):
 SeqUrn=[]
 u = random.uniform(0, 1)
 u -= ProbUrn[0]
 if u < 0:
     i = 0
 elif u-ProbUrn[1] < 0:
     i = 1
 else:
     i = 2
 SeqUrn.append(i)
 return SeqUrn,i
 
SeqUrn,i = startUrn(ProbUrn)  
  
#picking a ball
flag = True
while flag:
   u = random.uniform(0, 1)
   u -= DistUrn[i][0]/100
   if u < 0:
       GeneratedSeq += 'G'
   elif (u-DistUrn[i][1]/100) < 0:
       GeneratedSeq += 'R'
   else:
       GeneratedSeq += 'B'
   if len(GeneratedSeq) >= 5:
       if GeneratedSeq[-5:] == ReqSeq:
           flag = False
           break
  
   u = random.uniform(0, 1)
   u -= ProbSwitch[i][0]
   if u < 0:
       i = 0
   elif u-ProbSwitch[i][1] < 0:
       i = 1
   else:
       i = 2
   SeqUrn.append(i)
 
print(GeneratedSeq)
print(SeqUrn)
