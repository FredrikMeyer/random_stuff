#lang racket

;; computes the product (op x y) for all x in seq1 and y in seq2
(define (all-products op seq1 seq2)
  (define (all-prods-iter prods s)
    (if (empty? s)
        prods
        (let ((temp (cdr s)))
          (append prods (map (lambda (x) (op x (car s))) seq1)
                  (all-prods-iter prods temp)
                  )
          )
        )
    )
  (all-prods-iter '() seq2)
  )

(define (old-sol n)
(foldl + 0 (all-products (lambda (x y) (if (= x y) 0 (* x y)))
                                (range 1 (+ n 1)) (range 1 (+ n 1))))
  )


;;; mye raskere
;; 2 \cdot \sum_{i=1}^n \sum_{j=1}^{i-1} ij
(define (sum-not-squares n)
  (* 2
     (foldl + 0
            (map
             (lambda (i)
               (foldl + 0
                      (map (lambda (x) (* x i)) (range 1 i))))
             (range 1 (+ n 1)))
            )
     )
  )