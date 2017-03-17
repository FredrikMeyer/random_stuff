from matrices import *

M = Matrix([[1,2],[3,4]])

print M
print triangular(M)

N = Matrix([[1,1],[1,1]])

R = Matrix([[1,2,3],
	[4,5,6]])
S = Matrix([[1,3],[-1,2,],[0,1]])

W = Matrix([[4,6,7],[2,5,7],[8,5,2]])

M = Matrix([[12, 2],[18,5]])
print M
print triangular(M)

print R
RR = triangular(R)
print RR