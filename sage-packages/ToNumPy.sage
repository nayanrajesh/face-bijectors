import numpy as np
#dir = '/home/nayan/Documents/Polymath/face-bijectors/poset-numpy-data'
#os.chdir(dir)
#Take a set of posets and store a numpy array
def ToNumPy(Ps, name, dir = None):
	present= os.getcwd()
	if dir == None:
		dir = '/home/nayan/Documents/Polymath/face-bijectors/poset-numpy-data'
	os.chdir(dir)

	Relations = [P.relations() for P in Ps]
	data = np.asarray(Relations)
	np.save(name+'.npy', data, allow_pickle=True)	 	
	os.chdir(present)
	
