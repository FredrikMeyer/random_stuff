#lang scheme

(define (sign n)
  (if (> n 0) 1
      (- 1)
      )
  )

;; Exercise 2.1
(define (make-rat n d)
  (let ((g (gcd n d)))
  (cons (* (sign d) (/ n g)) (* (sign d) (/ d g))))
  )

(define (numer x) (car x))
(define (denom x) (cdr x))

(define (print-rat x)
  (newline)
  (display (numer x))
  (display "/")
  (display (denom x))
  )

(define (add-rat x y)
  (make-rat (+ (* (numer x) (denom y)) (* (denom x) (numer y)))
            (* (denom x) (denom y))
            )
  )


;;(define x (make-rat 1 2))
;;(define y (make-rat 3 4))

;; Exercise 2.2
(define (make-point x y)
  (cons x y)
  )

(define (x-point P)
  (car P)
  )

(define (y-point P)
  (cdr P)
  )

(define (make-segment p1 p2)
  (cons p1 p2)
  )

(define (start-segment s)
  (car s)
  )

(define (end-segment s)
  (cdr s)
  )

(define (midpoint-segment s)
  (let ((x1 (x-point (start-segment s)))
    (y1 (y-point (start-segment s)))
    (x2 (x-point (end-segment s)))
    (y2 (y-point (end-segment s))))
    (make-point (* 0.5 (+ x1 x2)) (* 0.5 (+ y1 y2)))
    )
  )

(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))N
  (display ")")
  )


;;;
;;; Ex 2.3
;;; Rectangler 