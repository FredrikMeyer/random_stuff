(define (square x)
	(* x x)
	)

(define (average x y)
	(* (+ x y) 0.5)
	)


(define (improve guess x)
	(average (/ x guess) guess)
	)


(define (isclose? guess x)
	(< (abs (- (square guess)  x)) 0.00001)
	)


(define (sqrtguess guess x)
	(if (isclose? guess x)
		guess
		(sqrtguess (improve guess x) x)
		))