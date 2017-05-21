#lang racket

(provide ex1.2
         ex1.3
         sqrt
         fib3rec
         fib3iter
         fast-exp
         carmichael?
         sum
         product
         accumulate
         double
         compose
         repeated)

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
;; If this is true, n is either prime or a Carmichael number
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

;; Exercise 1.29
(define (simpson f a b n)
  
  (let ([h (/ (- b a) n)])
    (define (inc x) (+ x 1))
    (define (fk k) (f (+ a (* k h))))
    (define (term k)
      (*
       (cond
         [(odd? k) 4.0]
         [(or (= k 0) (= k n)) 1.0]
         [else 2.0])
       (fk k)))
    (/ (* h (sum term 0 inc n)) 3)))

;; Exercises 1.30 - 1.32
(define (sum term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (+ (term a) result))))
  (iter a 0))

(define (accumulate combiner null-value term a next b)
  (define (iter val result)
    (if (> val b)
        result
        (iter (next val) (combiner (term val) result))))
  (iter a null-value))

(define (product term a next b)
  (accumulate (lambda (x y) (* x y)) 1 term a next b))

;; Exercise 1.41
(define (double f)
  (lambda (x) (f (f x))))

;; Exercise 1.42
(define (compose f g)
  (lambda (x) (f (g x))))

;; Exercise 1.43: returns a function that applies f n times
(define (repeated f n)
  (if (<= n 1)
      f
      (compose f (repeated f (- n 1)))))