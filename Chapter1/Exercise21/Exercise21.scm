; Exercise 1.21
; Using smallest-divisor functionality that is central to naive prime number detector

(define (smallest-divisor n)
	(find-divisor n 2))
	
(define (find-divisor n test-divisor)
	(cond ((> (square test-divisor) n) n)
		  ((divides? test-divisor n) test-divisor)
		  (else (find-divisor n (+ test-divisor 1)))))
	
(define (divides? a b)
	(= (remainder b a) 0))
	
; Smallest divisors:
;
; (smallest-divisor 199)
; 199
;
; (smallest-divisor 1999)
; 1999
;
; (smallest-divisor 19999)
; 7