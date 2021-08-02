#return all subgroups of Z_m
def AllSubgroups(m):
	Generators = [x for x in [2..((m//2)+1)] if gcd(x,m)!=1]
	HH = []
	for x in Generators:
		H = set(Generate(x, m))
		if H not in HH:
			HH.append(H)
	return [list(x) for x in HH]

#return <n> in m
def Generate(n,m):
	i = n
	H = [0]
	while(n!=0):
		H.append(n)
		n = mod(n+i, m)
	return H
def AllCosets(H,m):
	h = len(H)
	n = m//h
	GH=  []
	for i in range(0,n):
		Hi = [mod(h+i,m) for h in H]
		GH.append(Hi)
	return GH	

