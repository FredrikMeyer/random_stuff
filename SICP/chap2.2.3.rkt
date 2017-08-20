#lang scheme
(require "usefuls.rkt")


(define (accumulate op initial sequence)
  (if (null? sequence) initial
      (op (car sequence)
          (accumulate op initial (cdr sequence))
      )
      )
  )


;; Ex 2.33
;(define (map p sequence)
;  (accumulate (lambda (x y) (cons (p x) y)) null sequence)
;  )

(define (append seq1 seq2)
  (accumulate cons seq2 seq1)
  )

(define (length sequence)
  (accumulate (lambda (x y) (+ (length (cdr sequence)) 1)) 0 sequence)
  )

;;; ex 2.34

(define (horner-eval x coefficient-sequence)
  (accumulate (lambda (this-coeff higher-terms)
                (+ this-coeff (* x (horner-eval x (cdr coefficient-sequence))))
                )
              0
              coefficient-sequence)
  )

;; ex 2.35

(define (enumerate-tree x)
  (cond ((null? x) x)
        ((not (pair? x)) (list x))
        (else (append (enumerate-tree (car x)) (enumerate-tree (cdr x))))
        )
  )

(define (count-leaves t)
  (accumulate +
              0
              (map (lambda (x) 1 ) (enumerate-tree t))
              )
  )

(define t (list 1 (list 2 (list 3 4)) 5))

;; ex 2.36

(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      null
      (cons (accumulate op init (map (lambda (x) (car x)) seqs))
            (accumulate-n op init (map (lambda (x) (cdr x)) seqs))
            )
      )
  )

(define seqs
  (list (list 1 2 3)
        (list 4 5 6)
        (list 0 2 4)
        )
  )


;; ex 2.37

(define M (list (list 1 2 3 4)
                (list 4 5 6 6)
                (list 6 7 8 9)
                )
  )

(define v (list 1 2 3 4))

(define (dot-product v w)
  (accumulate + 0 (map * v w))
  )

(define (matrix-*-vector m v)
  (map (lambda (x) (dot-product x v)) m)
  )

(define (transpose mat)
  (accumulate-n cons '() mat))

(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map (lambda (v) (matrix-*-vector cols v))
         m)
    )
  )

;; Ex 2.38

(define (fold-left op init sequence)
  (define (fold-iter result rest)
    (if (null? rest)
        result
        (fold-iter (op result (car rest)) (cdr rest))
        )
    )
  (fold-iter init sequence)
  )

;; ex 2.39
(define (reverse2 seq)
  (accumulate (lambda (x y) (append y (list x))) null seq)
  )

(define (reverse3 seq) ;; y er cons av rest av lista
  (fold-left (lambda (x y) (cons y x)) null seq)
  )

;; 2.40

(define (flatmap proc seq)
  (accumulate append null (map proc seq)))

(define (prime-sum? pair)
  (prime? (+ (car pair) (cadr pair)))
  )

(define (make-pair-sum pair)
  (let ((a (car pair))
        (b (cadr pair))
        )
    (list a b (+ a b))
    )
  )

(define (prime-sum-pairs n)
  (map make-pair-sum
       (filter prime-sum?
               (flatmap
                (lambda (i)
                  (map (lambda (j) (list i j))
                       (enumerate-interval 1 (- i 1))))
                (enumerate-interval 2 n))
               )
       )
  )

;; 2.40 unique pairs

(define (unique-pairs n)
  (flatmap (lambda (i)
             (map (lambda (j) (list i j))
                  (enumerate-interval 1 (- i 1))
                  )
             )
       (enumerate-interval 2 n)
       )
  )

(define (prime-sum-pairs2 n)
  (map make-pair-sum
       (filter prime-sum? (unique-pairs n))
       )
  )

;; ex 2.41

;; all triples (i,j,k) with i+j+k=s (so k = s-i-j )
(define (unique-triples n)
  (flatmap (lambda (i)
         (flatmap (lambda (j)
                (map (lambda (k) (list i j k))
                       (enumerate-interval (+ j 1) n))
                     )
              (enumerate-interval (+ i 1) (- n 1))
              ))
   (enumerate-interval 1 (- n 2)))
  )

(define (triple-sum s n)
  (filter (lambda (list) (= (accumulate + 0 list) s))
          (unique-triples n))
  )

;;
;; implement take

(define (take n seq)
  (define (take-iter result rest k)
    (cond ((empty? rest) result)
          ((= k 0) result)
          (else
           (take-iter (cons (car rest) result) (cdr rest) (- k 1))
           )
          )
    )
  (take-iter '() seq n)
  )

;;;;