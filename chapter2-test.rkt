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