; Exercise 1.22
; Since computers are significantly faster now (2016) than they were when SICP was written,
; testing for primality on the numbers specified in this exercise is done too quickly to
; compare the relative times with Scheme's built-in measurement functionality. I intentionally
; slow down these calculations by repeating the same prime test 10,000 times for each number.
;
; Results - amount of time to compute the prime
; Number		|  Time (in ms)
; 1009			| 734
; 1013			| 750
; 1019			| 719
; 10007			| 2422
; 10009			| 2422
; 10037			| 2375
; 100003		| 7594
; 100019		| 7672
; 100043		| 7672
; 1000003		| 24141
; 1000033		| 23906
; 1000037		| 23938
;
; Based on these results, it seems reasonable that my computer's computations align with the big O
; estimate of complexity. When increasing the size of the primes numbers by a factor of 10 (1,000 to
; 10,000 to 100,000 to 1,000,000) the amount of time to test the primality of a number increased
; by a factor between 3.1 and 3.3. This is on par with this being a O(sqrt(n)) algorithm, in which
; increasing n by a factor of 10 would increase the complexity by an order of sqrt(n) = 3.16 (approximately).


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

(define (smallest-divisor n)
	(find-divisor n 2))
	
(define (find-divisor n test-divisor)
	(cond ((> (square test-divisor) n) n)
		  ((divides? test-divisor n) test-divisor)
		  (else (find-divisor n (+ test-divisor 1)))))
	
(define (divides? a b)
	(= (remainder b a) 0))
	
(define (prime? n)
	(let ((max 10000))
		(define (prime?-iter count)
			(cond ((< count max)
				(smallest-divisor n)
				(prime?-iter (+ count 1)))))
		(prime?-iter 1)
		(= (smallest-divisor n) n)))
	
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