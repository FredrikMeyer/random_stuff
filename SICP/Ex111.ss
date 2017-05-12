(define (f n)
	(cond ((< n 3) n)
		(else (+ (f (- n 1)) (* 2 (f (- n 2))) (* 3 (f (- n 3)))))
	)
	)

(define (fiter a b c n)
	(if (< n 3)
		a
		(fiter (+ a (* 2 b) (* 3 c)) a b (- n 1))
		)
	)
		
(define (ff n)
	(fiter 2 1 0 n)
	)