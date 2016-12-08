import random 
import matplotlib.pyplot as plt
import numpy as np

n = 500
L = range(n)
no_trials = 10000

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
for k in range(no_trials):
	P = random_permutation(L)
	l = len(orbit(P,0))
	lengths.append(l)

print sum(lengths)/float(len(lengths))
print min(lengths)
print max(lengths)

plt.hist(lengths, bins=10)
plt.show()

'''
Plots a histogram of the lengths of the orbit of 0 under
no_trials random permutations. It seems to be uniformly
distributed.
'''