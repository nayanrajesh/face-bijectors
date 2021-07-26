#-------------HELPER FUNCTIONS ------------------s

#X is a list and k is a number, this returns all possible sublists of size k
def Combin(X, n):
        if n == 0:
                return [[]]
        if X == []:
                return []
        return [[X[0]]+x for x in Combin (X[1:], n-1)] + [x for x in Combin (X[1:], n)]


def PowerSet(X):
        PS = []
        for i in range (1, len(X)+1):
                PS = PS + Combin(X,i)
        return PS



def Difference (A,B):
    return [x for x in A if x not in B]


def Perms(X):
 if len(X) == 1:
        return [[X[0]]]
 else:
        A=[]
        for i in X:
            for j in Perms(Difference (X, [i])):
                    A = A+[[i]+j]
        return A
	

def CombLists(ListofLists):
	L = []	
	for i in ListofLists:
		L = L+i
	return L	


#def mod(x,m):
#	return x%m
#	if x >=m:
#		while (x >=m):
#			x = x-m
#	if x <0:
#		while (x<0):
#			x = x+m
#	return x



#----------------POSET GENERATION--------------------------------------------


def InsertOptions(Poset, m, a):
	Options = []
	Done = [x for x in Poset]
	Atoms = [x for x in Poset if Poset.covers(0,x)]
	for n in Done:
		if mod(a-n,m) in Atoms:
			Options.append([n,a])
	return Options

#IN THE FOLLOWING FUNCTION, MAYBE IMPROVE EFFICIENCY BY GENERATING THESE VALID SUBSETS INSTEAD OF GENERATING ALL SUBSETS AND CHECKING FOR VALID ONES
#check whether adding a given set of relations to the poset satisfies the diamond property
def ValidSubsetToInsert7(Poset, m, Subset):
	NewRelations = Poset.relations() + Subset
	Elements = [x for x in Poset]+list(set([x[0] for x in NewRelations]+[x[1] for x in NewRelations]))
	#check diamond
	El = []
	for a in Elements:
		for b in Elements:
			ab = mod(a+b,m)
			if [a,ab] in NewRelations:
				for c in Elements:
					abc = mod(a+b+c,m)
					if [ab,abc] in NewRelations:
						ac = mod(a+c, m)
						if [a,ac] not in NewRelations:
							NewRelations.append([a,ac])
						
						if [ac, abc] not in NewRelations:
							NewRelations.append([ac,abc])
#			if [a,ab] in NewRelations and [b,ab] not in NewRelations:
#				NewRelations.append([b,ab])						
#			if [b,ab] in NewRelations and [a,ab] not in NewRelations:
#				NewRelations.append([a,ab])
	Elements = Elements+El
	return NewRelations







def ValidSubsetToInsert(P,m,Subset):
	NewRelations = P.relations()+Subset
	Elements = [x for x in P]+ list(set([x[0] for x in NewRelations]+[x[1] for x in NewRelations]))
	Ecopy = Elements
	while Ecopy!=[]:
		a = Ecopy[0]
		Ecopy =Ecopy[1:]
		for b in Elements:
			ab = mod(a+b,m)
			if [a,ab] in NewRelations:
				for c in Elements:
					abc = mod(a+b+c,m)
					if [ab,abc] in NewRelations:
						ac = mod(a+c,m)
						if [a,ac] not in NewRelations:
							NewRelations.append([a,ac])
							Ecopy.append(ac)
						if [ac,abc] not in NewRelations:
							NewRelations.append([ac,abc])
	return NewRelations












def ValidSubsetToInsert1(P,m,Subset):
	NewRelations = P.relations() + Subset
	Elements = [x for x in P] +list(set([x[0] for x in NewRelations]+[x[1] for x in NewRelations]))
	for a in Elements:
		B = [b for b in Elements if [a,mod(a+b,m)] in NewRelations]
		for b in B:
			C = [c for c in Elements if [mod(a+b,m), mod(a+b+c,m)] in NewRelations]
			for c in C:
				NewRelations.append([mod(a+c,m),mod(a+b+c,m)])
				NewRelations.append([mod(a,m),mod(a+c,m)])
	return NewRelations


def ValidSubsetToInsert0(P,m,Subset):
	NewRelations = P.relations()+Subset
	return NewRelations









def ValidInsertions(P, m,a):
	V = []
	InsertOp = InsertOptions(P,m,a)
	AllPossibleInsertions = PowerSet(InsertOp)
	for Insertion in AllPossibleInsertions:
		NewRelations =  ValidSubsetToInsert(P, m, Insertion)
#		print(NewRelations)
		Elements = [x for x in P] + list(set([x[0] for x in NewRelations]+[x[1] for x in NewRelations])) 
#		print(Elements)
		Elements.append(a)
		N = [x for x in NewRelations if x[0]!=x[1]]
		NewRelations = N
			#print(N)
		#Q = Poset([Elements, NewRelations])
		#V.append(Q)
		D = DiGraph(  NewRelations)	
		
		if D.is_directed_acyclic():
			Q = Poset(D)
			V.append(Q)
	return list(set(V))




def BuildTree(Ps, m, Perm):
	for p in Perm:
		F = [ValidInsertions(P, m, p) for P in Ps]
		Ps = CombLists(F)
	return Ps
 

def AtomSkeletons(m):
	Ps =[]
	A= [1..(m-1)]
	Skel = PowerSet(A)
	for x in Skel:
		El = x
		Rel = [(0,y) for y in x]
		Q = Poset ([El, Rel])
		Ps.append(Q)
	return Ps



def AllPosets(m,skeletons=None):
	Ps = []
	if skeletons:
		Skeletons = skeletons	
	else:
		Skeletons = AtomSkeletons(m)
	for Skeleton in Skeletons:
		D = [x for x in Skeleton]
		NotDone = Difference([1..(m-1)], D)
		InsertPerms = Perms(NotDone)
		for Perm in InsertPerms:
			Q = BuildTree([Skeleton], m, Perm)
			Ps = Ps+Q
	T = [x for x in Ps if Diamond(x)]
	Ps = T
	return list(set(Ps + [Skeletons.pop()]))
	 


























def Diamond(Poset):
    for a in Poset:
        for b in Poset:
            ab = mod(a+b, Poset.cardinality())
            if Poset.is_lequal(a,ab):
                for c in Poset:
                    abc = mod(a+b+c, Poset.cardinality())
                    ac = mod(a+c, Poset.cardinality())
                    if Poset.is_lequal(ab, abc) and ((Poset.is_lequal(a, ac)== False) or(Poset.is_lequal(ac, abc)) ==False ):
                        return False
    return True
