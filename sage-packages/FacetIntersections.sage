def FacetPosets(m):
	p = '/home/nayan/Documents/Polymath/face-bijectors/data/'
	return [x.poset for x in KunzPoset.ReadFacesFromNormaliz(face_lattice_file_path=os.path.join(p,'m'+str(m)+'facet.fac'), hplane_file_path=os.path.join(p,'m'+str(m)+'.out'))]

def FacetRelations(m):
	return [[x for x in P.relations() if x[0]!=0 and x[0]!=x[1]] for P in FacetPosets(m)]

