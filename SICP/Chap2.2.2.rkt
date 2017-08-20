#lang scheme

(define (count-leaves x)
  (cond ((empty? x) 0)
        ((not (pair? x)) 1)
        (else
         (+ (count-leaves (car x)) (count-leaves (cdr x)))
         )
        )
  )

(define (reverse x)
  (define (reverse-iter x y)
    (if (null? x) y
        (reverse-iter (cdr x) (cons (car x) y))
        )
    )
  (reverse-iter x '())
  )

(define (deep-reverse x)
  (define (reverse-iter x y)
    (if (null? x) y
        (cond ((pair? (car x))
               (reverse-iter (cdr x) (cons (reverse-iter (car x) '()) y)))
              (else
               (reverse-iter (cdr x) (cons (car x) y)))
              )
        )
    )
  (reverse-iter x '())
  )

(define x (cons (list 1 2) (list 3 4)))

;; ex 2.28

(define (fringe x)
  (cond ((null? x) null)
        ((not (pair? x)) (list x))
        (else            
      (append (fringe (car x)) (fringe (cdr x)))
      )
        )
  )

;; Ex 2.30

(define (square-tree tree)
  (map (lambda (sub-tree)
         (if (pair? sub-tree)
             (square-tree sub-tree)
             (* sub-tree sub-tree)
             )
         ) tree)
       )

(define (square-tree2 tree)
  (cond ((null? tree) null)
        ((not (pair? tree))
         (* tree tree)
         )
        (else (cons (square-tree2 (car tree)) (square-tree2 (cdr tree)))
              )
        )
  )

(define y
  (list 1
        (list 2 (list 3 4) 5)
        (list 6 7)
        )
  )

;; ex 2.31

(define (tree-map proc tree)
  (map (lambda (sub-tree)
         (if (pair? sub-tree)
             (tree-map proc sub-tree)
             (proc sub-tree)
             )
         ) tree)
  )



;; ex 2.32
;; 

(define (subsets s)
  (if (null? s)
      (list null)
      (let ((rest (subsets (cdr s))))
        (append rest (map (lambda (x) (cons (car s) x)) rest))
        )
      )
  )