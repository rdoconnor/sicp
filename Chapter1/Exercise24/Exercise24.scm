; Exercise 1.24
; Evaluating the performance of the Fermat primality test

; Results - amount of time to compute the prime (picked 10 random numbers for Fermat test for each prime)
; Number		|  Time (in ms)
; 1009			| 4359
; 1013			| 4468
; 1019			| 4672
; 10007			| 6078
; 10009			| 5859
; 10037			| 6062
; 100003		| 8453
; 100019		| 8781
; 100043		| 8868
; 1000003		| 9891
; 1000033		| 9828
; 1000037		| 10203
;

(define (search-for-primes start end)
	(define (search-for-primes-iter n)
		(cond ((< n end)
				(timed-prime-test n)
				(search-for-primes-iter (+ n 2)))))
	(if (even? start)
		(search-for-primes-iter (+ start 1))
		(search-for-primes-iter start)))
		
(define (search-for-next-primes start)
	(define (search-for-primes-iter n count)
		(cond ((< count 3)
				(if (timed-prime-test n)
					(set! count (+ count 1)))
				(search-for-primes-iter (+ n 2) count))))
	(if (even? start)
		(search-for-primes-iter (+ start 1) 0)
		(search-for-primes-iter start 0)))

(define (expmod base exp m)
	(cond ((= exp 0) 1)
		  ((even? exp)
			(remainder (square (expmod base (/ exp 2) m))
						m))
		  (else
			(remainder (* base (expmod base (- exp 1) m))
						m))))
(define (fermat-test n)
	(define (try-it a)
		(= (expmod a n n) a))
	(try-it (+ 1 (random (- n 1)))))
	
(define (fast-prime? n times)
	(cond ((= times 0) true)
		  ((fermat-test n) (fast-prime? n (- times 1)))
		  (else false)))
	
(define (prime? n)
	(let ((max 10000))
		(define (prime?-iter count)
			(cond ((< count max)
				(fast-prime? n 10)
				(prime?-iter (+ count 1)))))
		(prime?-iter 1)
		(fast-prime? n 10)))
	
(define (timed-prime-test n)
	(start-prime-test n (time-measurement)))

(define (start-prime-test n start-time)
	(if (prime? n)
		(report-prime n (- (time-measurement) start-time))
		#f))
		
(define (report-prime n elapsed-time)
	(newline)
	(display n)
	(display " *** ")
	(display elapsed-time)
	#t)
	
(define (time-measurement) (process-time-clock))