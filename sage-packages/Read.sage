load('/home/nayan/Downloads/sage-9.3/KunzPoset.sage')
def ReadPosets(m,d = None):
	p = '/home/nayan/Downloads/sage-9.3/data/'
	if d == None:
		return [x.poset for x in KunzPoset.ReadFacesFromNormaliz(face_lattice_file_path=os.path.join(p,'m'+str(m)+'.fac'), hplane_file_path=os.path.join(p,'m'+str(m)+'.out'))]
	else:	
		return [x.poset for x in KunzPoset.ReadFacesFromNormaliz(face_lattice_file_path=os.path.join(p,'m'+str(m)+'.fac'), hplane_file_path=os.path.join(p,'m'+str(m)+'.out'), dimension=d)]
		
