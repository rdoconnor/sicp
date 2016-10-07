; Exercise 1.23

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
		  (else (find-divisor n (next test-divisor)))))
	
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