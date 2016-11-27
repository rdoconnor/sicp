; Exercise 1.28
; Exploring the Carmichael numbers

; My Carmichael Test procedure verified that the following numbers from the Chapter
; are Carmichael numbers
; 561
; 1105
; 1729
; 2465
; 2821
; 6601

(define (expmod base exp m)
	(cond ((= exp 0) 1)
		  ((even? exp)
			(remainder (square (expmod base (/ exp 2) m))
						m))
		  (else
			(remainder (* base (expmod base (- exp 1) m))
						m))))

; This will return #t for carmichael numbers, #f otherwise
(define (carmichael-test n)
	; 1 if passes congruence test for primality
	(define (congruence-iter a)
		(cond ((>= a n) 1)
			  ((= (expmod a n n) a) (congruence-iter (+ a 1)))
			  (else 0)))
	; 1 if passes factor test for primality
	(define (factor-iter a)
		(cond ((>= a n) 1)
			  ((= (remainder n a) 0) 0)
			  (else (factor-iter (+ a 1)))))
	(and (= (congruence-iter 1) 1) (= (factor-iter 2) 0)))
