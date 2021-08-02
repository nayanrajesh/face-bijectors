#given a set of equivalence classes, an equivalence relation, and an element, x, this function inserts x into its equivalence class
# insert :: a -> [[a]]-> (a-> a-> Bool) -> [[a]]
def insert (x, classes, relation):
	#check if x is a representative of an equivalence class
	for i in range (0, len(classes)):
		if relation(classes[i][0], x) == True:
			return classes[:i] + [classes[i]+[x]] + classes [i+1:]
	return classes + [[x]]
			
#given a list and a relation, the function returns the list of equivalence classes
def equiv(initial, relation):
	equiv = []
	for i in initial:
		equiv = insert(i, equiv, relation)
	return equiv	




#defines a binary operation that returns true when two graphs are isomorphic, and false when not
def graphiso(g1, g2):
	if g1.is_isomorphic(g2):
		return True
	else:
		return False

#given a list of graphs, the function partitions the list where each partition has isomorphic graphs
def graphequiv(list_of_graphs):
	return equiv (list_of_graphs, graphiso)

#given a list of posets, this function converts them into directed graphs, paritions them according to isomorphism then converts them back to posets
def posetequiv(posets):
	graphs = [poset.hasse_diagram() for poset in posets]
	grapheq = graphequiv(graphs)
	#convert back to posets
	poseteq = []
	for a in grapheq:
		counter = []
		for b in a:
			counter = counter +[Poset(b)]
		poseteq.append(counter)
	return poseteq

#given a set of KunzPosets (the type of the output from ReadFacesFromNormaliz), this function converts each element to a Poset() type 
def kunztoposet(kunzposets):
	return [x.poset for x in kunzposets]




#takes a list of kunz posets, classifies them based on equivalence classes and saves plots in different folders
def Plot_Posets_Equivalence(posets,m,  path = os.getcwd()):
	P = posetequiv(posets)
	path = os.path.join(path, 'm'+str(m))
	os.mkdir(path)
	os.chdir(path)
	for i in range (0, len(P)):
		dir =  os.path.join(path, str(i))  
		os.mkdir(dir)
		os.chdir(dir)
		for j in range (0, len(P[i])):
			P[i][j].plot().save(str(j)+'.png')
		os.chdir(path)














