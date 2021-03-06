
#load('GeneratePosets.sage')







def GenerateFacetEquations(m):
	Eqns = []
	for i in range(1,m):
		for j in range(i,m):
			if mod(i+j,m)!=0:
				Eqn = (i,j,mod(i+j,m))
				Eqns.append(Eqn)
	return Eqns

def PrintFacetEquation(matrixequation, number=None):
	if number==None:
		print("x"+str(matrixequation[0])+" + x"+str(matrixequation[1])+" >= "+" x"+str(matrixequation[2]))
	else:
		print ("x"+str(matrixequation[0])+" + x"+str(matrixequation[1])+" >= "+" x"+str(matrixequation[2])+"-------"+str(number))
def PrintFacetEquations(m):
	Eqns = GenerateFacetEquations(m)
	for i in range(0,len(Eqns)):
		PrintFacetEquation(Eqns[i],number=i)

def PrintSomeFacetEquations(List):
	for i in range(0,len(List)):
		PrintFacetEquation(List[i], number=i)




#----------------------------------------------------------------------------------------------------------------

#Given a list of Eqns, check how many ways the lhs can be partitioned to add upto the rhs 
#LHS is a list for example [7,7,3,3,8,8]
#Pairs are how the terms add up (x_1+x_2) would be (1,2) 
#Term is the term on the rhs that is going to be rewritten
#m is multiplicity
def Factorize(LHS, Pairs, Term , m):
	Eq = GenerateFacetEquations(m)
	#Subs =list(set(LHS))
	Facs = []
	for x in Eq:
		if x[2] == Term:
			if x[0] in LHS:
				Temp=LHS.copy()
				Temp.remove(x[0])
				if x[1] in  Temp:
					if 0 ==0:

						Facs.append(x)
	#return Facs
	
	return Facs

#LHSReplace is a tuple ex (3,3,6) we're swapping out the two 3's on the lhs for the 6 on the rhs
def Replace(LHS, RHS, Fac):
	R = RHS.copy()
	R.remove(Fac[2])
	
	L = LHS.copy()
	L.remove(Fac[0])
	L.remove(Fac[1])
	return (L,R)



def Rewrite(Pairs, LHS,RHS,m, pnt=None):
	if LHS == [] and RHS == []:
		return True
	else:
		Li = []
		for Term in list(set(RHS)):
			Facs = Factorize (LHS, Pairs, Term, m) 
			for Fac in Facs:
				LH  = Replace(LHS, RHS,Fac)[0].copy()
				RH = Replace(LHS,RHS,Fac)[1].copy()
				#if pnt!=None:
					#print(LH,RH)
				print(LH,RH)				
#New = [Fac]
				if (Rewrite(Pairs, LH,RH,m)):
					#Rewrite(Pairs,LH,RH,m,pnt=1)
					#PrintEquations(LH,RH)
					return True
		return False
				
#returns True if Given Facet equations imply Fac
def RewriteFromFac(Pairs,LHS,RHS,Fac,m):
	if LHS ==[] and RHS ==[]:
		return True
	else:
		L = Replace(LHS,RHS,Fac)[0].copy()
		R = Replace(LHS,RHS,Fac)[1].copy()
		return Rewrite(Pairs, L,R,m)

def FacClosure(ExistingF, Pairs,LHS,RHS,m):
	C = []
	L = LHS.copy()
	Fax =[Factorize(L,Pairs, Term,m) for Term in list(set(RHS))]
	F = []
	for x in Fax:
		F=F+x
	Fax=F
	#print(Fax)
	Fax = [x for x in F if (x[0],x[1],x[2]) not in ExistingF and (x[1],x[0],x[2]) not in ExistingF]
	for Fac in Fax:
		L = LHS.copy()
		R = RHS.copy()	
		if RewriteFromFac(Pairs, L,R,Fac,m):
			C.append(Fac)	

	return RemoveRed(C)


def RemoveRed(Facs):
	for x in Facs:
		if (x[1],x[0],x[2]) in Facs and x[1]!=x[0]:
			Facs.remove(x)
	return list(set(Facs))

#---------------------------------------------------------------------------------------------------------------------------

#BACK TO POSETS!



def FacsFromPoset(P):
	Prel = P.relations()
	m = P.cardinality()
	Facs = [(x,mod(y-x,m),y) for [x,y] in Prel if x!=y and x!=0]
	Facs = RemoveRed(Facs)
	LHS = [x[0] for x in Facs] + [x[1] for x in Facs]
	RHS = [x[2] for x in Facs]
	Pairs = [(x[0],x[1]) for x in Facs]
	return (LHS,RHS,Pairs, Facs)


def CheckFacClosure(P, pnt=None):
	(LHS,RHS,Pairs,Facs) = FacsFromPoset(P)
	m  = P.cardinality()
	FC = FacClosure(Facs,Pairs,LHS,RHS,m)
	#X= [x for x in FC  if (x[0],x[1],x[2]) not in Facs and (x[1],x[0],x[2]) not in Facs]
	#return (X,Facs)
	if FC == []:
		return True
	else: 
		if pnt!=None:
			print("The following equations:")
			PrintSomeFacetEquations(Facs)
			print("imply these equations")
			PrintSomeFacetEquations(FC)
		return False
	


def CheckFacClosure2(P):
	(LHS,RHS,Pairs,Facs) = FacsFromPoset(P)
	LHS = LHS+LHS
	RHS=RHS+RHS
	m  = P.cardinality()
	FC = FacClosure(Facs,Pairs,LHS,RHS,m)
	#X= [x for x in FC  if (x[0],x[1],x[2]) not in Facs and (x[1],x[0],x[2]) not in Facs]
        #return (X,Facs)
	return FC == []

def PrintEquations(LHS,RHS):
	Str=""
	end = len(LHS)-1
	if LHS==[] or RHS ==[]:
		print()
		return None

	for i in range(0,end):
		Str = Str + "x"+str(LHS[i])+ " +"
	Str = Str + "x"+str(LHS[end])+ " ="
	end = len(RHS)-1
	for i in range(0,end):
		Str = Str + "x"+str(RHS[i])+ " +"
	Str = Str+ "x" + str(RHS[end]) 
	print(Str)

