present = os.getcwd()
kp = os.path.join(present, 'KunzPoset.sage')
load(kp)
import numpy as np
def ReadPosets(m,d = None):
	path = os.getcwd()
	os.chdir('../')
	os.chdir('data')
	p = os.getcwd()
	os.chdir(path)
	if d == None:
		
		return [x.poset for x in KunzPoset.ReadFacesFromNormaliz(face_lattice_file_path=os.path.join(p,'m'+str(m)+'.fac'), hplane_file_path=os.path.join(p,'m'+str(m)+'.out'))]
	else:	
		return [x.poset for x in KunzPoset.ReadFacesFromNormaliz(face_lattice_file_path=os.path.join(p,'m'+str(m)+'.fac'), hplane_file_path=os.path.join(p,'m'+str(m)+'.out'), dimension=d)]
		



def ArrayToPoset(Ar,m):
	El = [0..(m-1)]
	#print(El)
	Arr = Ar.tolist()
	print(Arr)
	P = [Poset([El, Rel]) for Rel in Arr]
	return P


def ReadFacePosetsNP(m):
	path = os.getcwd()
	os.chdir('../')
	os.chdir('poset-numpy-data')
	P = np.load('m'+str(m)+'_Faces.npy', allow_pickle=True)
	
	Ps = ArrayToPoset(P,m)
	return Ps

