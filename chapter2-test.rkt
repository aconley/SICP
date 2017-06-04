#lang racket

(require rackunit
         "chapter2.rkt")

;; Exercise 2.1
(test-begin
 (check-equal? (numer (make-rat 3 4)) 3)
 (check-equal? (denom (make-rat 3 4)) 4)
 (check-equal? (numer (make-rat -3 4)) -3)
 (check-equal? (denom (make-rat -3 4)) 4)
 (check-equal? (numer (make-rat 3 -4)) -3)
 (check-equal? (denom (make-rat 3 -4)) 4)
 (check-equal? (numer (make-rat -3 -4)) 3)
 (check-equal? (denom (make-rat -3 -4)) 4)
 (check-equal? (numer (make-rat -6 -8)) 3)
 (check-equal? (denom (make-rat -6 -8)) 4))

;; Exercise 2.4
(test-begin
 (check-equal? (church-car (church-cons 'a 'b)) 'a)
 (check-equal? (church-cdr (church-cons 'a 'b)) 'b))

;; Exercise 2.8
(test-begin
 (define a (make-interval 3 4))
 (define b (make-interval 5 10))
 (check-equal? (sub-interval b a) (make-interval 2 6))
 (check-equal? (sub-interval a b) (make-interval -6 -2)))

;; Exercise 2.17
(test-begin
 (check-equal? (last-pair (list 1 2 3 4)) '(4))
 (check-equal? (last-pair (list 3)) '(3))
 (check-equal? (last-pair '()) '()))

;; Exercise 2.18
(test-begin
 (check-equal? (reverse (list 1 2 3)) (list  3 2 1))
 (check-equal? (reverse '()) '())
 (check-equal? (reverse (list 1)) (list 1)))

;; Exercise 2.28
(test-begin
 (check-equal? (fringe '()) '())
 (define x (list (list 1 2) (list 3 4)))
 (check-equal? (fringe x) (list 1 2 3 4))
 (check-equal? (fringe (list x x)) (list 1 2 3 4 1 2 3 4)))