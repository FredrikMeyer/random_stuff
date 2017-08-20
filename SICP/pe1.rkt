#lang scheme
(#%require sicp-pict)

(define (sum L)
  (if (not (pair? L)) 0
      (+ (car L) (sum (cdr L)))
      )
  )

(define (is35multiple n)
  (if (or (= (remainder n 3) 0) (= (remainder n 5) 0))
      true
      false
      )
  )

(define (listab a b)
  (if (= a b) (list a)
      (cons a (listab (+ a 1) b))
      )
  )

(sum (filter is35multiple (listab 1 999)))
