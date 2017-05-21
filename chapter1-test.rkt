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
 