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
;;(test-begin
;; (for-each
;;  (lambda (el) (check-equal? (fib3rec el) (fib3iter el)))
;;  (list 1 2 3 4 5 6)))
  
 