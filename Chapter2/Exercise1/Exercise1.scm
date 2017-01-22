; Exercise 2.1
; Improving the rational number data type by handling signed numbers

(define (make-rat n d)
	(define (sign-factor)
		; Comparing the product against 0 was determined to be more efficient
		; on the cpu than checking the signs of the numerator and denominator twice
		;(cond ((or (and (< n 0) (>= d 0))
		;		   (and (>= n 0) (< d 0)))
		(cond ((< (* n d) 0)
				-1)
			  (else 1)))
	(let ((g (gcd n d)))
		(cons (* (sign-factor) (/ (abs n) g))
			  (/ (abs d) g))))
		
(define (numer x) (car x))

(define (denom x) (cdr x))
		
(define (print-rat x)
	(newline)
	(display (numer x))
	(display "/")
	(display (denom x))) 

; These test cases were used as:
; (1) unit tests to verify the validity of the improved make-rat constructor
; (2) as a means to better understand the performance implications of the possible implementations
(define (test-cases)
	(define (test-rational n d ans-n ans-d)
		(define (iter i)
			(if (< i 1000000)
				(let ((r (make-rat n d)))
					(assert (= (numer r) ans-n))
					(assert (= (denom r) ans-d))
					(iter (+ i 1)))))
		(let ((start (process-time-clock)))
			(iter 0)
			(display (- (process-time-clock) start))
			(newline)))
	(test-rational 1 2 1 2)
	(test-rational 2 4 1 2)
	(test-rational -2 4 -1 2)
	(test-rational -2 -4 1 2)
	(test-rational 2 -4 -1 2)
	(display "unit tests successful"))