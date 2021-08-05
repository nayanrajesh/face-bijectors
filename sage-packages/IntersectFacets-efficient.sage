load('/home/nayan/Documents/Polymath/face-bijectors/sage-packages/Read.sage')
load('/home/nayan/Documents/Polymath/face-bijectors/sage-packages/GeneratePosets.sage')
load('/home/nayan/Documents/Polymath/face-bijectors/sage-packages/ToNumPy.sage')

def FacetPosets(m):
	p = '/home/nayan/Documents/Polymath/face-bijectors/data/'
	return [x.poset for x in KunzPoset.ReadFacesFromNormaliz(face_lattice_file_path=os.path.join(p,'m'+str(m)+'facet.fac'), hplane_file_path=os.path.join(p,'m'+str(m)+'.out'))]

def FacetRelations(m):
        return [([(a,b) for [a,b] in FacetPosets(m)[i].relations() if a!=0 and a!=b],i) for i in range(0,len(FacetPosets(m)))]







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
	I = [x for x in Combin(FacetRel,n) if ValidNIntersections(x)]
	return I






def PossibleNPosets(m,n):
	I = PossibleNIntersections(m,n)
	Ps = []
	for Rels in I:
		NewRel = CombLists(Rels)
		N = [x for x in NewRel if x[0]!=x[1] ]+[[0,x] for x in range(0,m)]
		NewRel = N
		if 0==0:#if DiGraph(N).is_directed_acyclic():
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
	
