#lang scheme

;; EX 2.20
(define (same-parity x . z)
  (define (same-parity-inner x L)
    (if (empty? L) L
        (if (= (remainder (- x (car L)) 2) 0)
            (cons (car L) (same-parity-inner x (cdr L)))
            (same-parity-inner x (cdr L))
            )
        )
    )
  (same-parity-inner x z)
  )

;; EX 2.21

(define (square-list items)
  (define (square x) (* x x))
  (if (null? items)
      null
      (cons (square (car items)) (square-list (cdr items)))
      )
  )

;; ex 2.22

(define (square-list2 items)
  (define (square x) (* x x))
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons answer
                    (square (car things))
                    )
              )
        )
    )
  (iter items null)
  )

;; ex 2.23

(define (for-each proc items)
  (cond ((not (empty? items))
         (proc (car items))
         (for-each proc (cdr items))
         )
        )
  )