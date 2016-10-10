; Exercise 1.10
; Ackermann's Function

(define (A x y)
	(cond ((= y 0) 0)
		  ((= x 0) (* 2 y))
		  ((= y 1) 2)
		  (else (A (- x 1)
				   (A x (- y 1))))))
				   
(A 1 10)
; 1024

(A 2 4)
; 65536

(A 3 3)
; 65536

(define (f n) (A 0 n))
; (f n) => 2*n

(define (g n) (A 1 n))
; (g n) => 
; 0 if n = 0
; 2^n otherwise

(define (h n) (A 2 n))
; (h n) =>
; 0 if n = 0
; 2 <up-arrow> n otherwise
; where <up-arrow> is Knuth's up-arrow notation
; So this would be 2^2^2^...^2 where there would be n 2's in a chain of exponents (i.e. it grows insanely fast)
; For example (A 2 2), there are two 2's so (A 2 2) = 2 ^ 2
; for (A 2 3), there would be three 2's so (A 2 3) = 2 ^ 2 ^ 2
; for (A 2 4), there would be four 2's so (A 2 4) = 2 ^ 2 ^ 2 ^ 2
; Also, remember when evaluating chains of exponents, the exponent operator in mathematics is right-associative, so they're evaluated top to bottom
; So for 2 ^ 2 ^ 2 ^ 2, it would be evaluated in the following way:
; 2 ^ 2 ^ 4
; 2 ^ 16
; 65536