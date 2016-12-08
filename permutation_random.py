import random 

n = 1000
L = range(n)


def random_permutation(L):
	LL = list(L)
	random.shuffle(LL)
	return LL

def orbit(perm, k):
	'''
	Orbit of k under perm.
	'''
	orb = [k]
	im = perm[k]
	while (im != k):
		orb.append(im)
		im = perm[im]
	return orb

lengths = []
no_trials = 1000
for k in range(no_trials):
	P = random_permutation(L)
	l = len(orbit(P,0))
	lengths.append(l)

print sum(lengths)/float(len(lengths))
print min(lengths)
print max(lengths)
