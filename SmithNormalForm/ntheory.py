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
