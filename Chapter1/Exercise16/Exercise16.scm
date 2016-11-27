; Iterative log(n) exponentation

(define (fast-iter-exp base exponent)
	(define (iter a b n)
		(cond ((= n 0) a)
			  ((even? n) (iter a (square b) (/ n 2)))
			  (else (iter (* a b) b (- n 1)))))
	(iter 1 base exponent))
	
(define (unit-test)
	
	(define (iter-base base)
		(define (iter-exp exp)
			()