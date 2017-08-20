#lang scheme


;;
;; strategi: begynn å regne ut nederste brøken
;; først.
;; iterative
;;
(define (cont-frac n d k)
  (define (frac-iter F m) ;; if m is 0 stop
    (if (= m 0) F
        (frac-iter (/ (n m) (+ F (d m)))
                   (- m 1))
        ))
    (frac-iter 0 k)
  )

(define (approximate-e k)
  (define (n i) 1.)
  (define (d i)
    (if (= (remainder i 3) 2)
        (+ (* 2 (/ (- i 2) 3.)) 2)
        1.)
    )
  (+ (cont-frac n d k) 2)
  )

(define (tan-cf x k)
  (define (n i)
    (if (= i 1) x
        (- (* x x))
        )
    )
  (cont-frac n (lambda (i) (- (* 2. i) 1)) k)
  )