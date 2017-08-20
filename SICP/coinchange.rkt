#lang scheme

(define (count-change amount)
  (cc amount 5)
  )

(define (cc amount coin-values)
  (cond ((= amount 0) 1)
        ((or (< amount 0) (no-more? coin-values)) 0)
        (else (+ (cc amount (except-first-denomination coin-values))
                 (cc (- amount (first-denomination coin-values)) coin-values)
                 )
              )
        )
  )

(define (first-denomination coin-values)
  (car coin-values)
  )

(define (except-first-denomination coin-values)
  (cdr coin-values)
  )

(define (no-more? coin-values)
  (empty? coin-values)
  )

(define us-coins (list 25 50 10 5 1))
(define no-coins (list 20 10 5 1))

;; (cc 100 us-coins)