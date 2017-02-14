from math import sqrt, floor,pi
from fractions import Fraction

def sqrR(p):
	'''
	Solves naively the equation u^2 = -1 mod p.
	Returns 0 if no solution was found.
	'''
	for i in range(0,p):
		if (i**2) % p == p-1:
			return i
	return 0


def approximateFraction(a,n):
	'''
	Input: a real number a natural number n.
	Output: a pair [k,m], such that the fraction k/m is close 
	to a and  1<= m < n.
	'''
	L = [i*a-floor(i*a) for i in range(0,n+1)]
	mindiff = [1,0,0]
	for i in range(len(L)):
		for j in range(i+1,len(L)):
			if abs(L[i]-L[j]) < abs(mindiff[0]):
				mindiff = [(L[i]-L[j]),i,j]
	i,j = mindiff[1], mindiff[2]
	k = -int(round(L[i]-L[j]-(i-j)*a))
	m = i-j
	return [k,m]

def sumSquares(p):
	'''
	Input: a prime number p (must be congruent to 1 mod 4)
	Output: x and y such that x^2+y^2=p.
	'''
	n = int(floor(sqrt(p)))
	u = sqrR(p)
	[k,x] = approximateFraction(-u/float(p), n)
	y = x*u + k*p
	return abs(x),abs(y)

[k,m] = approximateFraction(sqrt(2),13)

print sumSquares(9857)
print [approximateFraction(pi,i) for i in range(1,100)]
print 22/7.
print pi
