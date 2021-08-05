load('/home/nayan/Documents/Polymath/face-bijectors/sage-packages/Read.sage')
load('/home/nayan/Documents/Polymath/face-bijectors/sage-packages/GeneratePosets.sage')
load('/home/nayan/Documents/Polymath/face-bijectors/sage-packages/ToNumPy.sage')

#def


def FacetPosets(m):
	p = '/home/nayan/Documents/Polymath/face-bijectors/data/'
	return [x.poset for x in KunzPoset.ReadFacesFromNormaliz(face_lattice_file_path=os.path.join(p,'m'+str(m)+'facet.fac'), hplane_file_path=os.path.join(p,'m'+str(m)+'.out'))]

def FacetRelations(m):
	X = [P.relations() for P in FacetPosets(m)]
	Y = [((a,b) for [a,b] in F) for F in X]
	return Y 


def ValidNIntersections(FacetRel):
	X = FacetRel
	while X!=[]:
		F1 = X[0]
		X = X[1:]
		for F in X:
			for Relation in F1:
				if Relation[1] !=Relation[0] and [Relation[1],Relation[0]] in F:
					return False
	return True


def PossibleNIntersections(m,n):
	FacetRel = FacetRelations(m)
	I = [list(x) for x in Subsets(FacetRel,n) if ValidNIntersections(x)]
	return I




def CombTuples(TupleofTuples):
	X = ()
	for x in TupleofTuples:
		X = X+x
	return X

def PossibleNPosets(m,n):
	I = PossibleNIntersections(m,n)
	Ps = []
	for Rels in I:
		NewRel = CombTuples(Rels)
		N = [x for x in NewRel if x[0]!=x[1]]
		NewRel = N
		if DiGraph(N).is_directed_acyclic():
			P = Poset([[0..(m-1)], NewRel])
			if Diamond(P):
				Ps.append(P)
	return Ps






def AllPosets(m):
	Ps = []
	P = Poset([[0..(m-1)], [[0,x] for x in [0..(m-1)]]])
	Ps.append(P)
	for i in range(1, m+2):
		Ps = Ps + PossibleNPosets(m,i)
	return list(set(Ps))





def AllPosetsSave(m):
	present = os.getcwd()
	dir = 'm'+str(m)+'saved-posets'
	if not os.path.exists(dir):
		os.mkdir('m'+str(m)+'saved-posets')
	os.chdir('m'+str(m)+'saved-posets')
	name = os.getcwd()
	P = Poset([[0..(m-1)], [[0,x] for x in [0..(m-1)]]])
	Ps = [P]
	ToNumPy(Ps,'0', name)
	for i in range(1, m+2):
		Ps = PossibleNPosets(m,i)
		ToNumPy(Ps, str(i), name)
	os.chdir(present)
	
