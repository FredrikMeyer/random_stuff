#lang scheme

(define (make-interval a b) (cons a b))
(define (upper-bound I) (cdr I))
(define (lower-bound I) (car I))

(define (add-interval x y)
  (make-interval (+ lower-bound x lower-bound y)
                 (+ (upper-bound x) (upper-bound y))
                 )
  )

;; Exercise 2.11
;; Rewrite by testing signs of end-points
(define (mul-interval x y)
  (cond ((and (> (lower-bound x) 0) (> (lower-bound y) 0))
         (make-interval (* (lower-bound x) (lower-bound y)) (* (upper-bound x) (upper-bound y)))
         )
        ((and (> (upper-bound x) 0) (< (lower-bound x) 0) (> (lower-bound y) 0))
         (make-interval (* (lower-bound x) (upper-bound y)) (* (upper-bound x) (upper-bound y)))
         )
        ((and (> (lower-bound x) 0) (< (lower-bound y) 0) (> (upper-bound y) 0))
         (make-interval (* (lower-bound y) (upper-bound x)) (* (upper-bound x) (upper-bound y)))
         )
        ((and (> (upper-bound x) 0) (< (lower-bound x) 0) (< (upper-bound y) 0))
         (make-interval (* (upper-bound x) (lower-bound y)) (* (lower-bound x) (lower-bound y)))
         )
        ((and (< (upper-bound x) 0) (> (upper-bound y) 0) (< (lower-bound y) 0))
         (make-interval (* (upper-bound y) (lower-bound x)) (* (lower-bound x) (lower-bound y)))
         )
        ((and (< (upper-bound x) 0) (< (upper-bound y) 0))
         (make-interval (* (upper-bound x) (upper-bound y)) (* (lower-bound x) (lower-bound y)))
         )
        ((and (> (lower-bound x) 0) (< (upper-bound y) 0))
         (make-interval (* (lower-bound y) (lower-bound x)) (* (lower-bound x) (upper-bound y)))
         )
        ((and (> (lower-bound y) 0) (< (upper-bound x) 0))
         (make-interval (* (lower-bound x) (lower-bound y)) (* (lower-bound y) (upper-bound x)))
         )
        (else (let ((p1 (* (lower-bound x) (upper-bound y)))
                    (p2 (* (lower-bound y) (upper-bound x)))
                    )
                (make-interval (min p1 p2) (max p1 p2))
                )
              )
         )
  )


(define (div-interval x y)
  (if (contains-zero? y)
       (display "interval contains zero!")
  (mul-interval x
                (make-interval (/ 1.0 (upper-bound y))
                               (/ 1.0 (lower-bound y))
                               )
                )
  )
  )
 

(define (sub-interval x y)
  (make-interval (- (lower-bound x) (upper-bound y))
                 (- (upper-bound x) (lower-bound y))
                 )
  )

;; returns true if I contains zero
(define (contains-zero? I)
  (if (< (* (lower-bound I) (upper-bound I)) 0)
      true
      false)
  )

(define (width x)
  (* 0.5 (- (upper-bound x) (lower-bound x)))
  )

(define (make-center-width c w)
  (make-interval (- c w) (+ c w))
  )

(define (center i)
  (* 0.5 (lower-bound i) (upper-bound i))
  )

(define (width i)
  (* 0.5 (- (upper-bound i) (lower-bound i)))
  )

(define (make-center-percent c p)
  (make-cente-width c (* p c))
  )

(define (percent I)
  (/ (width I) (center I))
  )
  

;;;
(define I1 (make-interval 1 2))
(define I2 (make-interval (- 1) 1))
