(define (square x)
	(* x x))

(define (sumOfSquares x y z)
	(+ (square x) (square y) (square z)))

(define (sumOfTwoLargest a b c)
	(- (sumOfSquares a b c) (* (min a b c) (min a b c))))