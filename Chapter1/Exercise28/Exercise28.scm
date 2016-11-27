; Exercise 1.28
; Miller-Rabin primality test

(define (expmod base exp m)
	(cond ((= exp 0) 1)
		  ((even? exp)
			(let ((pre-square (expmod base (/ exp 2) m)))
				(let ((post-square (remainder (square pre-square) m)))
					(cond ((and (not (or (= pre-square 1) (= pre-square (- m 1))))
								(= post-square 1))
						   0)
						  (else post-square)))))
		  (else
			(remainder (* base (expmod base (- exp 1) m))
						m))))
						
(define (fermat-test n)
	(define (try-it a)
		(not (= (expmod a (- n 1) n) 0)))
	(try-it (+ 1 (random (- n 1)))))
	
(define (fast-prime? n times)
	(cond ((= times 0) true)
		  ((fermat-test n) (fast-prime? n (- times 1)))
		  (else false)))