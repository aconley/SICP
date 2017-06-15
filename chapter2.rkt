#lang racket

(provide make-rat
         numer
         denom
         church-cons
         church-car
         church-cdr
         make-interval
         upper-bound
         lower-bound
         add-interval
         sub-interval
         last-pair
         reverse
         for-each
         fringe
         tree-map
         square-tree
         accumulate
         map2
         append2
         length2
         unique-pairs
         equal-symbol?)

;; Exercise 2.1: better version of make-rat
(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(define (make-rat n d)
  (define (make-rat-inner n d)
    (let ((g (gcd n d)))
      (cons (/ n g) (/ d g))))
  (cond [(< d 0) (make-rat-inner (- n) (- d))]
        [else (make-rat-inner n d)]))

(define numer car)
(define denom cdr)

;; Exercise 2.4 Lambda calculus for pairs
(define (church-cons x y)
  (lambda (m) (m x y)))
(define (church-car z)
  (z (lambda (p q) p)))
(define (church-cdr z)
  (z (lambda (p q) q)))

;; Exercise 2.7 + 2.8
(define make-interval cons)
(define upper-bound cdr)
(define lower-bound car)

(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))
(define (sub-interval x y)
  (let ([lower (- (lower-bound x) (lower-bound y))]
        [upper (- (upper-bound x) (upper-bound y))])
    (if (< upper lower)
        (make-interval upper lower)
        (make-interval lower upper))))

;; Exercise 2.17
(define (last-pair lst)
  (define (helper lst prev)
    (if (null? lst)
        prev
        (helper (cdr lst) (list (car lst)))))
  (helper lst '()))

;; Exercise 2.18
(define (reverse lst)
  (define (helper lst accum)
    (if (null? lst)
        accum
        (helper (cdr lst) (cons (car lst) accum))))
  (helper lst '()))

;; Exercise 2.23
(define (for-each f xs)
  (if (null? xs)
      '()
      (let ([x (car xs)]
            [rst (cdr xs)])
        (f x)
        (for-each f rst))))

;; Exercise 2.28
(define (fringe xs)
  (cond [(null? xs) '()]
        [(list? xs) (append (fringe (car xs)) (fringe (cdr xs)))]
        [else (list xs)]))

;; Exercise 2.31
(define (tree-map f tree)
  (cond [(null? tree) '()]
        [(not (pair? tree)) (f tree)]
        [else (cons (tree-map f (car tree))
                    (tree-map f (cdr tree)))]))
(define (square-tree tree) (tree-map (lambda (x) (* x x)) tree))

;; Exercise 2.33
(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

;; Exercise 2.40
(define (unique-pairs n)
  (for*/list ([i (in-range 2 n)]
              [j (in-range 1 i)])
    (cons i j)))

;; Exercise 2.54
(define (equal-symbol? a b)
  (cond [(and (symbol? a) (symbol? b)) (eq? a b)]
        [(and (list? a) (list? b))
         (cond [(null? a) (null? b)]
               [(null? b) (null? a)]
               [else (and (equal-symbol? (car a) (car b))
                          (equal-symbol? (cdr a) (cdr b)))])]
        [else #f]))


(define (map2 p seq)
  (accumulate (lambda (x y) (cons (p x) y)) '() seq))
(define (append2 seq1 seq2)
  (accumulate (lambda (x y) (cons x y)) seq2 seq1))
(define (length2 seq)
  (accumulate (lambda (x y) (+ y 1)) 0 seq))