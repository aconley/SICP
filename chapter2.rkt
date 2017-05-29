#lang racket

(provide make-rat
         numer
         denom
         church-cons
         church-car
         church-cdr)

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