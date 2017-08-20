#lang scheme

;; Ex 2.5

;; naive implementation of a^b O(n)
(define (pow a b)
  (if (= b 0)
      1
      (* a (pow a (- b 1)))
      )
  )

(define (cons x y)
  (* (pow 2 x) (pow 3 y))
  )

(define (car z)
  (if (> (remainder z 2) 0) 0
      (+ 1 (car (/ z 2)))
  )
  )

(define (cdr z)
  (if (> (remainder z 3) 0) 0
      (+ 1 (cdr (/ z 3)))
  )
  )