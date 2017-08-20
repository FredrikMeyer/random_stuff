(define (cube x)
	(* x x x)
)

(define (sum term a next b)
	(if (> a b) 0
	(+ (term a) (sum term (next a) next b))
	)
)

(define (inc n)
	(+ n 1)
	)

(define (identity x)
	x
	)

(define (sum-integers a b)
	(sum identity a inc b)
	)

(define (sum-cubes a b)
	(sum cube a inc b)
	)

(define (integral f a b dx)
	(define (next x)
		(+ x dx)
		)
	(* (sum f (+ a (* dx 0.5)) next b) dx)
	)

(define (integralsimpsons f a b n)
	(define (g k)
		(cond ((= k 0) (f a))
			((= k n) (f b))
			((= (remainder k 2) 1) (* 4. (f (+ a (* k (/ (- b a) n))))))
			((= (remainder k 2) 0) (* 2. (f (+ a (* k (/ (- b a) n))))))
			)
		)
	(/ (* (sum g 0 inc n) (/ (- b a) n)) 3)
)

(define (compose  f g)
	(lambda (x)
		(f (g x))
		)
	)