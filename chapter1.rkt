#lang racket

(provide ex1.2
         ex1.3
         sqrt
         fib3rec
         fib3iter
         fast-exp
         carmichael?)

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
  (cond ((< x 0) (error "argument to sqrt less than 0"))
        ((= x 0) 0)
        (else (sqrt-iter 1.0 0.5 x))))

;; Exercise 1.11: 3 term Fibonnaci
(define (fib3rec n)
  (cond [(< n 3) n]
        [else (+ (fib3rec (- n 1))
                 (* 2 (fib3rec (- n 2)))
                 (* 3 (fib3rec (- n 3))))]))

(define (fib3iter n)
  (define (iter fm1 fm2 fm3 count)
    (if (= count 0)
        fm3
        (iter (+ fm1 (* 2 fm2) (* 3 fm3)) fm1 fm2 (- count 1))))
  (iter 2 1 0 n))

;; Exercise 1.16 Fast exponentiation
(define (fast-exp b n)
  (define (fast-exp-helper a b n)  ;; invariant: the product is a b^n
    (cond
      [(= n 0) a]
      [(odd? n)
           (fast-exp-helper (* a b) b (- n 1))]
      [else (fast-exp-helper a (* b b) (/ n 2))]))
  (cond [(< n 0) (error "n must be >= 0")]
        [(= b 0) b]
        [(= b 1) b]
        [else (fast-exp-helper 1 b n)]))

;; Exercise 1.27: Carmichael Numbers

;; Computes b^n mod m
(define (expmod b n m)
  (define (expmod-helper a b n)
    (cond
      [(= n 0) a]
      [(odd? n)
           (remainder (expmod-helper (* a b) b (- n 1)) m)]
      [else (remainder (expmod-helper a (* b b) (/ n 2)) m)]))
  (cond [(< n 0) (error "n must be >= 0")]
        [(<= m 0) (error "m must be >= 0")] 
        [(= b 0) b]
        [(= b 1) b]
        [else (expmod-helper 1 b n)]))

;; Tests if a^n (mod n) == a (mod n) for all a in [1, n)
;;
(define (carmichael? n)
  ;; Tries a value a < n
  (define (test-a a)
    (= (expmod a n n) a))
  (define (loop idx)
    (if (< idx n)
        (if (test-a idx)
            (loop (+ idx 1))
            #f)
        #t))
  (loop 1))
      