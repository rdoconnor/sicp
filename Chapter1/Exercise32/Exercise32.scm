; Exercise 1.32
; Generalizing sum and product into an accumulate procedure
;
;

(define (accumulate-recursive combiner null-value term a next b)
	(cond ((> a b)
			null-value)
		  (else
			(combiner (term a)
					  (accumulate-recursive combiner null-value term (next a) next b)))))
					  
(define (accumulate-iterative combiner null-value term a next b)
	(define (iter i aggregate)
		(cond ((> i b)
				aggregate)
			  (else
				(iter (next i) (combiner (term i) aggregate)))))
	(iter a null-value))
					  
(define accumulate accumulate-iterative)

(define (sum term a next b)
	(accumulate + 0 term a next b))
	
(define (product term a next b)
	(accumulate * 1 term a next b))
	
	
; Procedures used for testing
	
(define (factorial n)
	(define (identity x) x)
	(define (increment x) (+ x 1))
	(product identity 1 increment n))
	
(define (cube n) (* n n n))

(define (inc n) (+ n 1))