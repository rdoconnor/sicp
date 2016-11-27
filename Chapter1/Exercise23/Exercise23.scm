; Exercise 1.23
; Evaluating the effectiveness of an optimization to the naive prime detection algorithm
;
; The optimization was eliminating half of the possible factors to check (the evens) in the smalltest-divisor procedure.
; There could be an expectation that this would now run twice as fact due to this optimization. However, I'm seeing speed
; increase by a factor of ~1.3 - 1.5 instead of by a factor of 2.
; This is is due to the extra check that needs to be done (the next procedure). Calling another procedure and having that procedure
; use the if statement introduce non-trivial performance costs that explain the smaller speed-up factor.
; Based on some quick benchmarking, a majority of the unexpected performance cost is associated with the if statement, while the rest
; is associated with the performance overhead associated with calling another procedure (which can be avoided with inlining the next procedure).
;
; Results - amount of time to compute the prime
; Number		| Optimized Time (in ms)			| Non-optimized Time (in ms) (results from 1.22)
; 1009			| 552								| 734
; 1013			| 542								| 750
; 1019			| 536								| 719
; 10007			| 1640								| 2422
; 10009			| 1704								| 2422
; 10037			| 1640								| 2375
; 100003		| 5171								| 7594
; 100019		| 5141								| 7672
; 100043		| 5187								| 7672
; 1000003		| 16312								| 24141
; 1000033		| 16172								| 23906
; 1000037		| 16344								| 23938

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
	(faster-find-divisor n 2))
	
(define (find-divisor n test-divisor)
	(cond ((> (square test-divisor) n) n)
		  ((divides? test-divisor n) test-divisor)
		  (else (find-divisor n (next test-divisor)))))
		  
; Does inlining help?
; Yes
(define (faster-find-divisor n test-divisor)
	(cond ((> (square test-divisor) n) n)
		  ((divides? test-divisor n) test-divisor)
		  ((= test-divisor 2) (faster-find-divisor n 3))
		  (else (faster-find-divisor n (+ test-divisor 2)))))
	
(define (next test-divisor)
		(if (= test-divisor 2)
			3
			(+ test-divisor 2)))

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