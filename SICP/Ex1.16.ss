(define (fastexpt b n)
	(define (even? n)
		(= (remainder n 2) 0)
		)
	(define (square n)
		(* n n)
		)
	(define (expiter a b n) ;; ab^n is constant 
		(cond ((= n 0) a)
			((even? n) (expiter (* a (square b)) (square b) (- (/ n 2) 1)))
			(else (expiter (* a b) b (- n 1)))
			)
		)
	(expiter 1 b n)
	)