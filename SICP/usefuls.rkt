#lang scheme

(provide square)
(define (square x)
  (* x x)
  )


(provide enumerate-interval)
(define (enumerate-interval a b)
  (if (= a b) (list b)
      (cons a (enumerate-interval (+ a 1) b))
      )
  )

(define (divides? a b)
  (= (remainder b a) 0)
  )

(define (find-divisor n test-divisor)
	(cond ((> (square test-divisor) n) n)
		((divides? test-divisor n) test-divisor)
		(else (find-divisor n (+ test-divisor 1)))
		)
	)

(define (smallest-divisor n)
  (find-divisor n 2)
  )

(provide prime?)
(define (prime? n)
  (= (smallest-divisor n) n)
  )


(provide accumulate)
(define (accumulate op initial sequence)
  (if (null? sequence) initial
      (op (car sequence)
          (accumulate op initial (cdr sequence))
      )
      )
  )

(provide flatmap)
(define (flatmap proc seq)
  (accumulate append null (map proc seq)))
