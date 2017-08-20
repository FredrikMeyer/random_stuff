#lang scheme

(define tolerance 0.0001)
(define (average x y)
  (* (+ x y) 0.5))

(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess turn)
    (let ((next (f guess)))
      (display guess)
      (newline)
      (display turn)
      (newline)
      (if (close-enough? guess next)
          next
          (try next (+ turn 1)))))
  (try first-guess 1))

(define (sqrt x)
  (fixed-point (lambda (y) (average y (/ x y))) 1.0))

(define (ex136_without_damping n)
  (fixed-point (lambda (x) (/ (log n) (log x))) 2))

(define (ex136_with_damping n)
  (fixed-point (lambda(x) (average x (/ (log n) (log x)))) 2))