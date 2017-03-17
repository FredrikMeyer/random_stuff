'''
TODO:
 - Hermite normal form

 SOFAR:
 - Upper triangular over integers.
'''

import ntheory
from operator import mul

class Matrix:
	"""
	Consructs a matrix object from a double list.
	"""
	def __init__(self, L):  
		self.L = L
		self.m = len(L[0]) # number of columns
		self.n = len(L) # number of rows

	def checkFormat(self,L):
		'''
		To be written. Checks if the matrix is welldefined.
		'''
		return True

	def __add__(self,M):
		'''
		Returns the sum of self and M.
		'''
		newL = []
		for r in range(self.m):
			row = [self.L[r][i] + M.L[r][i] for i in range(self.n)]
			newL += [row]
		return Matrix(newL)

	def __sub__(self,N):
		return (self + (-N))

	def __neg__(self):
		newL = [[-r for r in R] for R in self.L]
		return Matrix(newL)

	def __mul__(self,N):
		'''
		Returns the product of self and N.
		'''
		NT = N.transpose()
		newL = []
		for i in range(self.n):
			newR = []
			for j in range(N.m):
				newR += [sum([self.L[i][k]*NT.L[j][k] for k in range(self.m)])] # dot product of row vs column
			newL += [newR]
		return Matrix(newL)

	def transpose(self):
		'''
		Returns the transpose of self.
		'''
		newL = [[] for i in range(self.m)]
		for i in range(len(self.L)):
			for j in range(self.m):
				newL[j] += [self.L[i][j]]
		return Matrix(newL)

	def trace(self):
		'''
		If self is square, return trace.
		'''
		if self.n != self.m:
			return "NOT SQUARE"
		return sum([self.L[i][i] for i in range(self.n)])

	## Row operations:

	def mult(self,c):
		newL = [[c*r for r in R] for R in self.L]
		return Matrix(newL)

	def switchRows(self,i,j):
		'''
		Returns the matrix obtained by switching rows i,j in self.
		Counting starts at 0.
		'''
		newL = list(self.L)
		newL[i], newL[j] = newL[j], newL[i]
		return Matrix(newL)

	def multRow(self,i,c = -1):
		'''
		Multiplies row i with c. (plus minus 1)
		'''
		newL = list(self.L)
		newL[i] = [c*r for r in newL[i]]
		return Matrix(newL)

	def addRow(self,i,j,a=1):
		'''
		Adds a times row j to row i.
		'''
		newL = list(self.L)
		rowj = list(self.L[j])
		newL[i] = [self.L[i][j]+a*rowj[j] for j in range(len(rowj))]
		return Matrix(newL)

	def _prodDiagonal(self):
		return reduce(mul,[self.L[i][i] for i in range(len(self.L))],1)

	def det(self):
		return triangular(self)._prodDiagonal()


	def __str__(self):
		s = "{0}x{1}-matrix: ".format(self.m,self.n) + str(self.L[0]) + "\n"
		for row in self.L[1:]:
			 s+= 12*" " + str(row) + "\n"
		return s[:-1] + "."

def identity(n):
	L = []
	for i in range(n):
		L += [[int(j == i) for j in range(n)]]
	return Matrix(L)

def concat(M,N):
	'''
	Input: M nxm matrix.
	       N n-1 x m-1 matrix.
	Output: A new matrix with Q with N the
	 submatrix obtained by removing first col and row.
	 '''
	L = [M.L[0]]
	for i in range(1,len(M.L)):
		R = [M.L[i][0]]
		for j in range(len(N.L[0])):
			R += [N.L[i-1][j]]
		L += [R]
	return Matrix(L)

def submatrix(M,c=0,r=0):
	'''
	The submatrix obtained by removing col c and row r.
	'''
	L = []
	for i in range(len(M.L)):
		if i != r:
			R = []
			for j in range(len(M.L[0])):
				if j != c:
					R += [M.L[i][j]]
			L += [R]
	return Matrix(L)


def triangular(M):
	'''
	Input: an integer matrix M.
	Output: an upper triangulization U of M over the integers.
	Algorithm:
	 1. Find smallest nonzero element X in first column. Move this element to the top row.
	    If there are no nonzero elements go to step 3.
	 2. Use Bezout/Koszul-row operation to remove the next nonzero element below X. 
	 3. Repeat with the submatrix obtained by removing the first row and column.
	 4. Concatenate.
	 TODO:
	 *also return the matrix V such that VM=U.
	'''
	if len(M.L) == 1:
		if M.L[0][0] < 0:
			return -M
		return M
	(index, smallest) = (0,M.L[0][0])
	for i in range(len(M.L)):
		if abs(M.L[i][0])  < smallest:
			(index, smallest) = (i,M.L[i][0])
	if smallest == 0:
		return concat(M,triangular(submatrix(M)))
	if index != 0:
		N = M.switchRows(0,index)   ### row operation
	else:
		N = Matrix(M.L)
	for i in range(1,len(M.L)):
		d = ntheory.gcd(smallest, N.L[i][0])
		bez = ntheory.bezout(smallest, N.L[i][0])
		I = identity(len(N.L))     # Construct elementary matrix and multiply on the left.
		I.L[0][0] = bez[0]
		I.L[0][i] = bez[1]
		I.L[i][0] = N.L[i][0]/d
		I.L[i][i] = -N.L[0][0]/d
		N = I * N
		if N.L[0][0] < 0:
			N = N.mult(-1)
	return concat(N,triangular(submatrix(N)))