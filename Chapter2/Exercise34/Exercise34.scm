; Exercise 2.34
; Horner's rule

; Accumulate procedure provided in section 2.2.1
(define (accumulate op initial sequence)
	(if (null? sequence)
		initial
		(op (car sequence)
			(accumulate op initial (cdr sequence)))))

(define (horner-eval x coefficient-sequence)
	(accumulate (lambda (this-coeff higher-terms) (+ this-coeff (* x higher-terms)))
				0
				coefficient-sequence))
				
(define (unit-tests)
	(define (test-answer x argument solution)
		(assert (equal? (horner-eval x argument) solution)))
	(test-answer 0 '() 0)
	(test-answer 1 (list 1) 1)
	(test-answer 2 (list 1 3 0 5 0 1) 79)
	(display "tests completed successfully"))