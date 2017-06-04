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
         fringe)

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
     