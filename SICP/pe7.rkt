#lang racket

(define (divides? a b)
  (= (remainder b a) 0)
  )

(define (square x) (* x x))

(define (find-divisor n test-divisor)
	(cond ((> (square test-divisor) n) n)
		((divides? test-divisor n) test-divisor)
		(else (find-divisor n (+ test-divisor 1)))
		)
	)

(define (smallest-divisor n)
  (find-divisor n 2)
  )

(define (isprime? n)
  (= (smallest-divisor n) n)
  )

(define (divides-in-list n seq)
  (if (empty? seq)
      false
      (if (= (remainder n (car seq)) 0)
          true
          (divides-in-list n (cdr seq))
          )
      )
  )

(define (list-of-primes n)
  (define (lop-iter k a seq)
    (if (= k 0) '()
        (if (divides-in-list a seq)
            (lop-iter k (+ a 1) seq)
            (cons a (lop-iter (- k 1) (+ a 1) (cons a seq)))
        )
    ))
  (lop-iter n 2 '())
  )

