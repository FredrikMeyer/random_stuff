import math

def nested_square(a,t):
	f = lambda x: math.sqrt(2 + x)
	a = math.sqrt(a)
	for i in range(t):
		a = f(a)
	return a

def viete_pi(n):
	p = 1
	i = 0
	while i < n:
		p *= nested_square(2,i)/2
		i += 1
	return 2/p


if __name__ == "__main__":
	print [math.pi-viete_pi(i) for i in range(20)]