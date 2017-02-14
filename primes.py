from math import *
from operator import mul

def isprime(n, why=False):
    '''
    Checks if a number n is 
    prime.
    '''
    if n == 1:
        return False
    if n == 2:
        return True
    if n % 2 == 0:
        return False
    if n == 3:
        return True
    if n % 3 == 0:
        return False
    sq = int(floor(sqrt(n)))
    i = 5
    while i <= sq:
        if n % i == 0:
            return False
        if n % (i+2) == 0:
            return False
        i += 6
    return True

def readlist(filename):
    f = open(filename,"r")
    
    s = f.readline()
    f.close()
    s = [int(i) for i in s.split()]
    
    return s    
    
def primecount(n):
    ''' number of primes less than or equal to n'''
    s = 0
    i = 0
    while i <= n:
        if isprime(i):
            s += 1
        i += 1
    return s
    
def d(n):
    '''
    the sum of the proper divisors of n
    '''
    if n == 0:
        return 0
    s = 0
    for i in range(1,n):
        if n % i == 0:
            s += i
    return s 

def phi(n):
    '''
    Eulers totient function. Sum of numbers
    less than n, prime to n.
    '''
    if n == 1:
        return 1
    s = 0
    for i in range(1,n):
        if gcd(i,n) == 1:
            s += 1
    return s

def phiL(n):
    '''
    Probably more effective than phi(n). Uses primelist.txt
    which contains a list of primes below 1 mill.
    '''
    r = 1.
    L = readlist("primelist.txt")
    for i in L:
        if n % i == 0:
            r *= (1-(1./i))
        if i >= n:
            break
    return int(r*n)

def ndphi(n):
    '''
    The quotient n/phi(n).
    Uses the result that
    phi(n) = n * P(1-1/p)
    '''
    s = 1.
    for i in factors(n):
        s *= 1-1./i
    return 1./s

def is_squarefree(n):
    for j in range(2,int(sqrt(n))+1):
        if n % j**2 == 0:
            return False
    return True

def mobius(n):
    if not is_squarefree(n):
        return 0
    if len(factors(n)) % 2 == 0:
        return 1
    return -1
    
def factors(n):
    '''
    n <= 100000 since this is the bound in primelist
    can be made more effective,
    e.g. by checking square root bounds
    '''
    p = []
    L = readlist("primelist.txt")
    for i in L:
        if n % i == 0:
            p += [i]
        if i >= n:
            break
    return p

def radical(n):
    return reduce(operator.mul, factors(n))

def order(n,p):
    '''
    returns the order of n at p.
    f.ex ord(24,2)=3 since 24/8 but 16 not
    '''
    ordr = 0
    while n % p == 0:
        ordr += 1
        n /= p
    return ordr

def degree(n):
    '''
    the degree of a number n
    is the sum of the exponents in
    its factorization
    '''
    return reduce(lambda x, y: x+y, [order(n,p) for p in factors(n)])

def nfactors(n):
    '''
    note: n <= 100.000
    '''
    return len(factors(n))

def orderVector(n):
    '''
    the list [a1,...,am]
    where a1...am are the exponents
    in a prime factorization of n
    '''
    L = []
    for p in factors(n):
        L += [order(n,p)]
    return L

def combine(divisors, ordervector):
    '''
    returns the number n
    corresponding to divisors/orderVector
    '''
    if len(divisors) != len(ordervector):
        return False
    prod = 1
    for q in range(len(divisors)):
        prod *= divisors[q]**ordervector[q]
    return prod

def listOfSmallerVectors(ordervector):
    '''
    given an ordervector w, return list of
    v < w
    '''
    l = [] # to be returned
    v = zeros(len(ordervector))
    #for i in range(len(ordervector)):
    return False

def zeros(n):
    '''
    makes n zeros as a list
    '''
    return [0 for i in range(n)]

def addVectors(v,w):
    if len(v) != len(w):
        print "v, w must be of same length!"
        return False
    l = []
    for i in range(len(v)):
        l += [v[i]+w[i]]
    return l

def isSmallerThan(v,w):
    '''
    given two exponent vectors,
    return True if v_i <= w_i for all i
    '''
    if len(v) != len(w):
        print "v, w must be of same length!"
        return False
    for i in range(len(v)):
        if v[i] > w[i]:
            return False
    return True

def isPandigital(n):
    '''
    checks if a number contains all
    123...9 exactly once
    '''
    if n > 987654321:
        return False
    if n < 123456789:
        return False
    strL = list(str(n))
    nl = [int(i) for i in strL]
    for i in range(1,10):
        try:
            nl.remove(i)
        except:
            return False
    if len(nl) != 0:
        return False
    return True

def gcd(a,b):
    a,b = (abs(a),abs(b))
    while b != 0:
        if b > a:
            a,b = b,a
        a, b = b , a % b
    return a

def bezout(a,b):
    '''
    Returns a Bezout identity (as a tuple of two elts) for
    two numbers a,b. I.e. two numbers x,y such that
      ax+by=gcd(a,b)
    '''
    if b == 0:
        return (1,0)
    else:
        r = a % b
        q = (a-r)/b
        (s,t) = bezout(b,r)
        return (t,s-q*t)

def sumdigits(n, base=10):
    s = 0
    while n != 0:
        s += n % base
        n = (n-(n % base))/base
    return s

def numberofdigits(n, base=10):
    s = 0
    while n != 0:
        s += 1
        n = (n-(n % base))/base
    return s

def continuedfraction(n,a):
    '''
    returns the convergents
    [a(0),a(1),...,a(n)]
    as a list of fractions
    [[p(0),q(0)],...,[p(n),q(n)]]
    '''
    p = [a(0),a(1)*a(0)+1]
    q = [1,a(1)]

    for i in range(2,n):
        p += [a(i)*p[i-1]+p[i-2]]
        q += [a(i)*q[i-1]+q[i-2]]
    return [[p[i],q[i]] for i in range(len(p))]

def continuedfraction_squareroot(S,n):
    '''
    returns the function a for
    continuedfraction(n,a), converging
    to sqroot(n)
    '''
    aList = []
    m = 0
    d = 1
    a0 = floor(sqrt(S))
    a = floor(sqrt(S))
    c = 1
    while c <= n:
        aList.append(int(a))
        m = d*a-m
        d = (S-m**2)/float(d)
        a = floor((a0+m)/float(d))
        c += 1
    def af(k):
        if k < n:
            return aList[k]
        else:
            return 0
    return af 

def diophantine(D):
    '''
    Finds the least x value solving the
    equation x^2-Dy^2=1.
    The method used is by a continued fraction
    approximation of sqrt(D).

    See f.ex Wikipedia for algorithm. Almost the
    same symbols used here.

    NB NB NB! Input must NEVER be square. That
    will result in division by zero.

    Originally written for ProjectEuler P66.
    '''

    m = floor(sqrt(D))
    d = D-m**2
    a = int(floor((sqrt(D)+m)/d))

    lastp = int(floor((sqrt(D)+m)/d))*int(floor(sqrt(D)))+1
    lastlastp = int(floor(sqrt(D)))
    lastq = a
    lastlastq = 1

    while lastp**2-D*lastq**2 != 1:
        m = d*a-m
        d = (D-m**2)/float(d)
        a = int(floor((sqrt(D)+m)/d))
        l = lastp
        lastp = a*lastp+lastlastp
        lastlastp = l
        q = lastq
        lastq = a*lastq+lastlastq
        lastlastq = q
    return lastp

def solveMod(a,b,n):
    '''
    Uses a Bezout identity to solve ax=b mod (n).
    '''
    return  bezout(a,n)[0]

def chineseRemainder(A,M):
    '''
    Solves the Chinese Remainder problem, that is, finds an 
    x such that x = a_i mod m_i for a_i,m_i in A,M.
    '''
    n = len(M)
    Mis =  [reduce(mul,[M[i] for i in range(n) if i != j],1) for j in range(n)]
    lambdas = [solveMod(Mis[i],1,M[i]) for i in range(n)]
    x =  sum([A[i]*lambdas[i]*Mis[i] for i in range(n)])
    P = reduce(mul,M,1)
    if x < 0:
        x = P+x
    while x - P > 0:
        x = x - P
    return x    

def choose(n,k):
    c = 1.
    for j in range(1,k+1):
        c *= (n-(k-j))/float(j)
    return int(c)

if __name__ == "__main__":
    print bezout(15,13)
    print bezout(4,4)
    print gcd(-16,8)
    print bezout(-16,8)
    print choose(6,3)
    print "..."
    print chineseRemainder([2,3,5],[4,5,7])
    print "..."
    print readlist("primelist.txt")
