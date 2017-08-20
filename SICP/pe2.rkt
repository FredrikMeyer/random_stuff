#lang racket

(define (fib m)
  (define (fib-iter result a k)
    (if (= k 0) result
        (fib-iter (+ result a) result (- k 1))
        )
    )
  (fib-iter 1 0 m)
  )



(foldl + 0
       (filter (lambda (x) (and (> 4000000 x) (even? x)))
               (map fib (build-list 40 values))) ;; works because fib(40) >> 4 mill
       )