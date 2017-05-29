#lang racket

(provide make-rat
         numer
         denom)

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