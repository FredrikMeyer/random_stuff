(define (cube x)
	(* x x x))

(define (iter guess x)
	(/ (+ (/ x (* guess guess)) (* 2. guess)) 3))

(define (isclose? guess x)
	(< (abs (- (cube guess) x)) 0.0001)
	)

(define (cuberoot-iter guess x)
	(if (isclose? guess x)
		guess
		(cuberoot-iter (iter guess x) x)))

(define (cuberoot x)
	(cuberoot-iter 1 x)
	)