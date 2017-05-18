#lang racket

;; Exercise 1.2
(define ex1.2
  (let ([upper (+ 5 4 (- 2 (- 3 (+ 6 (/ 4 5)))))]
        [lower (* 3 (- 6 2) (- 2 7))])
    (/ upper lower)))

;; Exercise 1.3: Define a procedure that takes 3 arguments and retuns the
;; sum of the squares of the two larger numbers.
(define (ex1.3 x y z)
  (define (max-two a b c)
    (if (>= a b)
        (if (>= b c)
            (list a b)
            (list a c))
        (if (>= a c)
            (list b a)
            (list b c))))
  (apply (lambda (a b) (+ (* a a) (* b b))) (max-two x y z)))

;; Exercise 1.7: Improve the definition of good enough in the sqrt procedure
(define (sqrt x)
  (define (square x) (* x x))
  (define (average x y) (/ (+ x y) 2))
  (define (good-enough? guess prev-guess x)
    (and (< (abs (- guess prev-guess)) (abs (* guess 0.001)))
         (< (abs (- (square guess) x)) 0.001)))
  (define (improve guess x)
    (average guess (/ x guess)))
  (define (sqrt-iter guess prev-guess x)
    (if (good-enough? guess prev-guess x)
        guess
        (sqrt-iter (improve guess x) guess x)))
  (sqrt-iter 1.0 0.5 x))

;; Exercise 1.11: 3 term Fibonnaci
(define (fib3rec n)
  (cond ((< n 3) n)
        (else (+ (fib3rec (- n 1)) (* 2 (fib3rec (- n 2))) (* 3 (fib3rec (- n 3)))))))

(define (fib3iter n)
  (define (iter fm1 fm2 fm3 count)
    (if (= count 0)
        fm3
        (iter (+ fm1 (* 2 fm2) (* 3 fm3)) fm1 fm2 (- count 1))))
  (iter 2 1 0 n))