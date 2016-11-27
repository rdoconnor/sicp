; Exercise 1.26
; Why Louis Reasoner is having such trouble

; By using multiplication instead of square, Louis is creating a process that calls
; expmod twice in each step where it previously only called it once.
; This is resulting in tree recursion with exponential growth. O(e ^ log(n)) = O(n)

; Expmod from before:
(define (original-expmod base exp m)
	(cond ((= exp 0) 1)
		  ((even? exp)
			(remainder (square (original-expmod base (/ exp 2) m))
						m))
		  (else
			(remainder (* base (original-expmod base (- exp 1) m))
						m))))
						
; Louis's expmod:
(define (new-expmod base exp m)
	(cond ((= exp 0) 1)
		  ((even? exp)
			(remainder (* (new-expmod base (/ exp 2) m)
						  (new-expmod base (/ exp 2) m))
						m))
		  (else
			(remainder (* base (new-expmod base (- exp 1) m))
						m))))