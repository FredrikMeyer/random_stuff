#lang scheme

(define tolerance 0.0001)
(define dx 0.00001)

(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance)
    )
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess)
  )

(define (deriv g)
  (lambda (x)
    (/ (- (g (+ x dx)) (g x)) dx)
    )
  )

(define (newton-transform g)
  (lambda (x)
    (- x (/ (g x) ((deriv g) x)))
    )
  )

(define (newtons-method g guess)
  (fixed-point (newton-transform g) guess)
  )

(define (square x)
  (* x x)
  )

(define (cube x)
  (* x x x)
  )

(define (average x y)
  (* 0.5 (+ x y))
  )

(define (sqrt x)
  (newtons-method (lambda (y) (- (square y) x)) 1.0)
  )

(define (fixed-point-of-transform g transform guess)
  (fixed-point (transform g) guess)
  )

;; exercise 1.40
(define (cubic a b c)
  (lambda (x) (+ (cube x) (* a (square x)) (* b x) c))
  )

;; exercise 1.41
(define (double g)
  (lambda (x) (g (g x)))
  )

(define (inc n)
  (+ n 1)
  )

;; exercise 1.42

(define (compose f g)
  (lambda (x) (f (g x))
    )
  )

;; exercise 1.43

(define (repeated f n)
  (if (= n 1)
      (lambda (x) (f x))
      (repeated (compose f f) (- n 1))
      )
  )

;; exercise 1.44
;; use dx value from above
(define (sawtooth  x)
  (if (< x 0) 0
      1)
  )

(define (smooth f)
  (lambda (x) (/ (+ (f (- x dx)) (f x) (f (+ x dx))) 3.))
  )

(define (nsmooth f n)
  (if (= n 0)
      (lambda (x) (f x))
      (nsmooth (smooth f) (- n 1))
      )
  )
      