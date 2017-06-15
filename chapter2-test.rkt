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

;; Exercise 2.31
(test-begin
 (define t1 (list 1 (list 2 (list 3 4) 5) (list 6 7)))
 (define t1sq (list 1 (list 4 (list 9 16) 25) (list 36 49)))
 (check-equal? (square-tree t1) t1sq))

;; Exercise 2.33
(test-begin
 (check-equal? (map2 add1 (list 1 2 3)) (list 2 3 4))
 (check-equal? (map2 add1 '()) '())
 (check-equal? (append2 (list 2 3) (list 4 5)) (list 2 3 4 5))
 (check-equal? (append2 (list 2 3) '()) (list 2 3))
 (check-equal? (append2 '() (list 1 2)) (list 1 2))
 (check-equal? (append2 '() '()) '())
 (check-equal? (length2 '()) 0)
 (check-equal? (length2 (list 1)) 1)
 (check-equal? (length2 (list 1 2 3 4)) 4))

;; Exercise 2.54
(test-begin
 (check-true (equal-symbol? '(this is a list) '(this is a list)))
 (check-false (equal-symbol? '(this is a list) '(this (is a) list))))