; Exercise 1.29
; Simpson's Rule for better numerical integration

; Comparison between "conventional" numerical integration and Simpson's Rule
; Both were compared for integrating y = x^3 over x=0 to x=1 with 100 and 1000
; steps. This means calculations with dx = 0.01 and dx = 0.001 for the default
; integration and n = 100 and n = 1000 for Simpson's.
;
; Results: Simpson's Method Wins
;
; 100 steps
; Default (dx = 0.01) -> 0.24998750000000042
; Simpson's (n = 100) -> 0.24999999999999992
;
; 1000 steps
; Default (dx = 0.001) -> 0.249999875000001
; Simpson's (n = 1000) -> 0.2500000000000003
;

(define (sum term a next b)
	(if (> a b)
		0
		(+ (term a)
		   (sum term (next a) next b))))
		   
(define (integral f a b dx)
	(define (add-dx x) (+ x dx))
	(* (sum f (+ a (/ dx 2.0)) add-dx b)
		dx))
		
(define (simpsons-integral f a b n)
	(define (get-h) (/ (- b a) n))
	(define (get-y k) (f (+ a (* k (get-h)))))
	(define (get-coefficient k)
		(cond ((or (= k 0) (= k n)) 1)
			  ((even? k) 2)
			  (else 4)))	(define (get-term k)
		(* (get-coefficient k) (get-y k)))
	(define (inc x) (+ x 1))
	(* (sum get-term 0 inc n)
		(/ (get-h) 3)))
		
(define (cube x) (* x x x))