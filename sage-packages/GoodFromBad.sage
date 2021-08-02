load('/home/nayan/Documents/Polymath/face-bijectors/sage-packages/Read.sage')
	
#If all of the relations of P are in Q
def IsSubPoset(P,Q):
	Prel = set([(a,b) for [a,b] in P.relations()])
	Qrel = set([(a,b) for [a,b] in Q.relations()])
	return Prel.issubset(Qrel)


def GoodFromBadInBackGround(P, BackgroundSet):
	minlen = oo
	good = None
	for x in BackgroundSet:
		if len(x.relations()) < minlen:
			if IsSubPoset(P, x):
				good = x
				minlen = len(x.relations())
	return good		
	
def GoodFromBad(P):
	m = P.cardinality()
	return GoodFromBadInBackGround(P, ReadPosets(m))



def PartitionGFB(Posets):
	m = Posets[0].cardinality()
	Partition = []
	CorGood = []
	Minimal = []
	Back = ReadPosets(m, numpy = True)
	for P in Posets:
		G = GoodFromBadInBackGround(P, Back)
		if G in CorGood:
			i = CorGood.index(G)
			if IsSubPoset(P, Minimal[i]):
				Minimal[i] = P
			Partition[i].append(P)
			
		else:
			CorGood.append(G)
			Minimal.append(P)
			Partition.append([P])
	return [(Partition[i], CorGood[i], Minimal[i]) for i in range(0, len(Partition))]

