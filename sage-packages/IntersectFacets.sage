load('/home/nayan/Documents/Polymath/face-bijectors/sage-packages/Read.sage')
load('/home/nayan/Documents/Polymath/face-bijectors/sage-packages/GeneratePosets.sage')

def FacetPosets(m):
	p = '/home/nayan/Documents/Polymath/face-bijectors/data/'
	return [x.poset for x in KunzPoset.ReadFacesFromNormaliz(face_lattice_file_path=os.path.join(p,'m'+str(m)+'facet.fac'), hplane_file_path=os.path.join(p,'m'+str(m)+'.out'))]

def FacetRelations(m):
	return [P.relations() for P in FacetPosets(m)]



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
		N = [x for x in NewRel if x[0]!=x[1]]
		NewRel = N
		if DiGraph(N).is_directed_acyclic():
			P = Poset([[0..(m-1)], NewRel])
			if Diamond(P):
				Ps.append(P)
	return Ps






def AllPosets(m):
	Ps = []
	for i in range(1, m+2):
		Ps = Ps + PossibleNPosets(m,i)
	return list(set(Ps))





