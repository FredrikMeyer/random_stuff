#lang racket

;; from number to list (first element is first ten)
(define (number-to-list n)
  (if (< n 10) (list n)
      (let ((rest (/ (- n (remainder n 10)) 10)))
        (cons (remainder n 10) (number-to-list rest))
        )
      )
  )

(define (list-to-number seq)
  (if (empty? (cdr seq))
      (car seq)
      (+ (car seq) (* 10 (list-to-number (cdr seq))))
      )
  )

(define (is-palindrome? n)
  (let ((seq (number-to-list n)))
    (equal? seq (reverse seq))
    )
  )

(define (all-products seq)
  (define (all-prod-iter prods s2 ss)
    (if (empty? s2)
        prods
        (let ((inp s2))
          (append prods (map (lambda (x) (* x (car s2))) ss)
                  (all-prod-iter prods (cdr s2) (cdr ss))
                  )
          )
        )
    )
  (all-prod-iter '() seq seq)
  )

(time 
(foldl max 0
       (filter is-palindrome?
               (all-products (build-list 900 (lambda (x) (+ x 100))))
               )
       ))