; Exercise 2.17
; Getting the last element in a list

(define (last-pair items)
	(cond ((or (null? items) (null? (cdr items)))
			items)
		  (else (last-pair (cdr items)))))
		  
		  
(define (unit-tests)
	(define (test-answer argument solution)
		(assert (equal? (last-pair argument) solution)))
	(test-answer (list 23 72 149 34) (list 34))
	(test-answer '() '())
	(test-answer (list 1) (list 1))
	(display "test cases completed successfully"))