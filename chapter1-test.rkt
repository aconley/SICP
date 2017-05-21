#lang racket

(require rackunit
         "chapter1.rkt")

;; Tests for exercise 1.3
(test-begin
 (check-equal? (ex1.3 1 1 1) 2)
 (check-equal? (ex1.3 2 3 1) 13)
 (check-equal? (ex1.3 3 1 2) 13)
 (check-equal? (ex1.3 -3 1 1) 2))

;; Tests for exercise 1.7
(test-begin
 (check-equal? (sqrt 0) 0)
 (check-true (< (abs (- (sqrt 1) 1)) 0.001))
 (check-true (< (abs (- (sqrt 4) 2)) 0.001)))

;; Fib 3
(test-begin
 (check-equal? (fib3iter 0) 0)
 (check-equal? (fib3iter 1) 1)
 (check-equal? (fib3iter 2) 2)
 (check-equal? (fib3iter 11) 4489)
 (for-each
  (lambda (el) (check-equal? (fib3rec el) (fib3iter el)))
  (list 1 2 3 4 5 6)))

;; fast-exp
(test-begin
 (check-equal? (fast-exp 0 5) 0)
 (check-equal? (fast-exp 1 10) 1)
 (check-equal? (fast-exp 11 1) 11)
 (check-equal? (fast-exp 2 15) 32768)
 (check-equal? (fast-exp 2 16) 65536)
 (check-equal? (fast-exp 10 5) 100000))

;; carmichael test
(test-begin
 (for-each (lambda (el) (check-true (carmichael? el)))
           (list 2 3 5 7 11 13 17 19 23 29))
 (for-each (lambda (el) (check-false (carmichael? el)))
           (list 4 9 12 14 20 21 24 100 105))
 (check-true (carmichael? 561))
 (check-true (carmichael? 1105))
 (check-true (carmichael? 1729))
 (check-false (carmichael? 1731)))

;; Exercises 1.30-1.32
(define (inc x) (+ x 1))
(define (inc2 x) (+ x 2))
(define (ident x) x)
(define (sq x) (* x x))

(test-begin
 (check-equal? (sum ident 0 inc 5) (+ 0 1 2 3 4 5))
 (check-equal? (sum ident 10 inc 14) (+ 10 11 12 13 14))
 (check-equal? (sum ident 10 inc 10) 10)
 (check-equal? (sum ident 11 inc 10) 0)
 (check-equal? (sum ident -4 inc 3) (+ -4 -3 -2 -1 0 1 2 3))
 (check-equal? (sum sq -4 inc2 3) (+ 16 4 0 4)))

(test-begin
 (check-equal? (product ident 1 inc 4) (* 1 2 3 4))
 (check-equal? (product ident -2 inc 4) 0)
 (check-equal? (product ident -1 inc2 4) (* -1 1 3))
 (check-equal? (product sq 3 inc2 6) (* 9 25)))

;; Exercise 1.41
(test-begin
 (check-equal? ((double inc) 5) 7)
 (check-equal? (((double double) inc) 5) 9)
 (check-equal? (((double (double double)) inc) 5) 21))

;; Exercise 1.42
(test-begin
 (check-equal? ((compose sq inc) 6) (* 7 7)))

;; Exercise 1.43
(test-begin
 (check-equal? ((repeated inc 5) 4) 9)
 (check-equal? ((repeated sq 2) 5) 625))