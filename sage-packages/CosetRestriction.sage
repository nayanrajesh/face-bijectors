load('/home/nayan/Documents/Polymath/face-bijectors/sage-packages/Subgroup.sage')


#checks if Coset is a subset of atoms: If a+G subset of Atoms
def CosetSubsetOfAtoms(Atoms, m):
	HH = AllSubgroups(m)
	C = []
	for H in HH:
		Cosets = AllCosets(H,m)
		for Coset in Cosets:
			if [x for x in Coset if x in Atoms]==Coset:
				C.append(Coset)
	return C

#returns h in P for which i < h where i in a+G
def CosetLessThan(Coset, P):
	L = []
	for i in Coset:
		for h in [x for x in P if x not in Coset]:
			if P.is_less_than(i, h):
				L.append(h)

	return L

#checks if i < h for some i in a+G implies that i < h for all i in a+G
def WholeCosetLessThan(Coset, P):
	L = CosetLessThan(Coset, P)
	for l in L:
		if set([x for x in Coset if P.is_less_than(x, l)]) != set(Coset):
			return False
	return True

def CosetRestrictionCheck(P):
	m = P.cardinality()
	Atoms =[x for x in P if P.covers(0,x)]
	PossibleCosets = CosetSubsetOfAtoms(Atoms, m)
	for Coset in PossibleCosets:
		if not WholeCosetLessThan(Coset, P):
			return False
	return True	
	
	


