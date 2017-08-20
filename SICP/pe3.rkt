#lang racket

(define (square x)
  (* x x)
  )

(define (smallest-divisor n)
  (find-divisor n 2)
  )

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))
        )
  )

(define (divides? a b)
  (= (remainder b a) 0)
  )

(define (prime? n)
  (= n (smallest-divisor n))
  )

(define (prime-factors n)
  (let ((a (smallest-divisor n)))
    (if (prime? n) (list n)
        (cons a (prime-factors (/ n a)))
        )
    )
  )

(define (largest-prime-factor n)
  (foldl max 0 (prime-factors n))
  )