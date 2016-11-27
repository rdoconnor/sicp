; Exercise 1.38
; Using continued fractions to estimate e

(define (cont-frac n d k)
	(define (iter i total)
		(cond ((< i 1)
				total)
			  (else
				(iter (- i 1) (/ (n i) (+ (d i) total))))))
	(iter k 0))

; Based on Euler's conjecture that e - 2 can be estimated by the
; continued fraction with N(i) = 1.0 and D(i) following the pattern
; 1, 2, 1, 1, 4, 1, 1, 6, 1, 1, 8, ...
(define (estimate-e k)
	(define (n i) 1.0)
	(define (d i)
		(cond ((= (remainder i 3) 2) 
				(* 2.0 (+ (floor (/ i 3)) 1)))
			  (else 1.0)))
	(+ 2 (cont-frac n d k)))