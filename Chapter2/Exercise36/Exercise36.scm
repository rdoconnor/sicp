; Exercise 2.36
; accumulate-n

; Accumulate procedure provided in section 2.2.1
(define (accumulate op initial sequence)
	(if (null? sequence)
		initial
		(op (car sequence)
			(accumulate op initial (cdr sequence)))))
			
(define (accumulate-n op init seqs)
	(if (null? (car seqs))
		'()
		(cons (accumulate op init (map car seqs))
			  (accumulate-n op init (map cdr seqs)))))
			  
(define (unit-tests)
	(define (test-answer op init seqs solution)
		(assert (equal? (accumulate-n op init seqs) solution)))
	(test-answer + 0 (list '() '()) '())
	(test-answer + 0 (list (list 1 2 3) (list 4 5 6) (list 7 8 9) (list 10 11 12)) (list 22 26 30))
	(display "tests completed successfully"))