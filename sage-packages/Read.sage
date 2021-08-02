#present = os.getcwd()
#kp = os.path.join(present, 'KunzPoset.sage')
load('/home/nayan/Documents/Polymath/face-bijectors/sage-packages/KunzPoset.sage')
import numpy as np
def ReadPosets(m,d = None, numpy =False):

	present = os.getcwd()
	if numpy == False:
	
		p = '/home/nayan/Documents/Polymath/face-bijectors/data/'
		os.chdir(p)
		X = [x.poset for x in KunzPoset.ReadFacesFromNormaliz(face_lattice_file_path=os.path.join(p,'m'+str(m)+'.fac'), hplane_file_path=os.path.join(p,'m'+str(m)+'.out'))]
	else:
		p = '/home/nayan/Documents/Polymath/face-bijectors/poset-numpy-data/'
		os.chdir(p)
		Ps = np.load('m'+str(m)+'-faces.npy', allow_pickle=True)
		X = ArrayToPoset(Ps,m)
	os.chdir(present)
	return X
		



def ArrayToPoset(Ar,m):
	El = [0..(m-1)]
	#print(El)
	Arr = Ar.tolist()
#	print(Arr)
	P = [Poset([El, Rel]) for Rel in Arr]
	return P


def ReadFacePosetsNP(m):
	path = os.getcwd()
	os.chdir('../')
	os.chdir('poset-numpy-data')
	P = np.load('m'+str(m)+'_Faces.npy', allow_pickle=True)
	
	Ps = ArrayToPoset(P,m)
	return Ps


























