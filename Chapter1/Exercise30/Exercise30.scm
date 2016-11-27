; Exercise 1.30
; Iterative process for sum procedure

(define (sum-iterative term a next b)
	(define (iter a result)
		(if (> a b)
			result
			(iter (next a) (+ result (term a)))))
	(iter a 0))
		
(define (sum-recursive term a next b)
	(if (> a b)
		0
		(+ (term a)
		   (sum-recursive term (next a) next b))))
