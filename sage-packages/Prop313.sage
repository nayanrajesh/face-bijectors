load('/home/nayan/Documents/Polymath/face-bijectors/sage-packages/Subgroup.sage')

#returns all the elements of the poset that satisfy a \in G\H and 2a \notin H
def AFromSubGroup(Poset, H):
    m = Poset.cardinality()
    GminusH = [x for x in Poset if x not in H]
    A2NotinH = [x for x in GminusH if mod(x+x,m) not in H]
    return A2NotinH








#Checks Prop313(a)
def Check3131(Poset, a, H):
    m = Poset.cardinality()

    flag = 0
    for b in H:
        l = 0
        for i in [mod(a+h, m) for h in H]:
            if Poset.is_lequal(i, mod(i+i+b, m)):
                l=l+1
        if l == len(H):
            flag =1
            break
    return (flag == 1)
    
#Checks Prop 313(b)    
def Check3132(Poset, a, H):
    m = Poset.cardinality()
    for i in [mod(a+h,m) for h in H]:
        for j in [mod(a+a+h,m) for h in H]:
            if not Poset.is_lequal(i,j):
                return False
            
    return True

#For all Subgroups, H of Z_m and for a corresponding to each subgroup such that a \in G\H and 2a \notin H, check if
#Prop313(a) is equivalent to Prop313(b)
def Prop313(Poset):
    m = Poset.cardinality()
    
    HH = AllSubgroups(m)
    for H in HH:
        A = AFromSubGroup(Poset, H)
        for a in A:
            if Check3131(Poset, a, H) != Check3132(Poset, a,H):
                return False
        return True
