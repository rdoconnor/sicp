; Exercise 2.18
; Reversing the elements of a list

(define (reverse items)
	(define (iter original-list new-list)
		(if (null? original-list)
			new-list
			(iter (cdr original-list) (cons (car original-list) new-list))))
	(iter items '()))
	
	
(define (unit-tests)
	(define (test-answer argument solution)
		(assert (equal? (reverse argument) solution)))
	(test-answer (list 1 4 9 16 25) (list 25 16 9 4 1))
	(test-answer (list 1) (list 1))
	(test-answer (list 1 2) (list 2 1))
	(test-answer '() '())
	(display "test cases completed successfully"))