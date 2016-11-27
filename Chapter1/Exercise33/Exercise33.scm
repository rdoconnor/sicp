; Exercise 1.33
; Generalizing accumulate with filter
;

; If filter? is true for x, then include (term x) in accumulation
(define (filtered-accumulate-recursive filter? combiner null-value term a next b)
	(cond ((> a b) null-value)
		  ((filter? a)
			(combiner (term a)
					  (filtered-accumulate-recursive filter? combiner null-value term (next a) next b)))
		  (else (filtered-accumulate-recursive filter? combiner null-value term (next a) next b))))
		  
(define filtered-accumulate filtered-accumulate-recursive)

(define (prime? n)
	(define (iter i)
		(cond ((> (square i) n) #t)
			  ((= (remainder n i) 0) #f)
			  (else (iter (+ i 1)))))
	(iter 2))

	
; Sum of squares of prime numbers in the interval a to b
(define (sum-of-squares-of-primes a b)
	(filtered-accumulate prime? + 0 square a inc b))

(define (product-ints-relative-prime-n n)
	(define (relative-prime-n? i)
		(= (gcd n i) 1))
	(define (identity i) i)
	(filtered-accumulate relative-prime-n? * 1 identity 1 inc (- n` 1)))

; Procedures used for testing
(define (accumulate combiner null-value term a next b)
	(define (always-true x) #t)
	(filtered-accumulate always-true combiner null-value term a next b))
	
(define (sum term a next b)
	(accumulate + 0 term a next b))
	
(define (product term a next b)
	(accumulate * 1 term a next b))
	
(define (factorial n)
	(define (identity x) x)
	(define (increment x) (+ x 1))
	(product identity 1 increment n))
	
(define (cube n) (* n n n))

(define (inc n) (+ n 1))

(define (prime? n)
	(define (iter i)
		(cond ((> (square i) n) #t)
			  ((= (remainder n i) 0) #f)
			  (else (iter (+ i 1)))))
	(iter 2))