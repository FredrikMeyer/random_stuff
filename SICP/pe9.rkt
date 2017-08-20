#lang scheme

(require "usefuls.rkt")

;; a = m^2-n^2
;; b = 2mn
;; c = m^2+n^2
;; a+b+c = 2m^2-2mn

;; a+b+c=1000 => m^2-mn = m(m-n) = 500 = 2*2*5*5*5

(define (make-pairs k)
(flatmap (lambda (i)
       (map (lambda (j)
              (cons i j)) (enumerate-interval i k))) (enumerate-interval 1 k))
  )


(define (select proc seq)
  (define (select-iter res l)
    (if (empty? l) res
        (if (proc (car l))
            (select-iter (cons (car l) res) (cdr l))
            (select-iter res (cdr l))
            )
        )
    )
  (select-iter null seq)
  )

(select (lambda (p) (= (* (car p) (cdr p)) 500)) (make-pairs 500))