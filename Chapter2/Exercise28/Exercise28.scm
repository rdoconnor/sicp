; Exercise 2.28
; Returning a list of leaves

(define (fringe tree)
	(cond ((null? tree) '())
		  ((not (pair? tree)) (list tree))
		  (else
			(append (fringe (car tree))
					(fringe (cdr tree))))))
					
(define (unit-tests)
	(define (test-answer argument solution)
		(assert (equal? (fringe argument) solution)))
	(define x (list (list 1 2) (list 3 4)))
	(test-answer '() '())
	(test-answer (list 1) (list 1))
	(test-answer (list 1 2) (list 1 2))
	(test-answer x (list 1 2 3 4))
	(test-answer (list x x) (list 1 2 3 4 1 2 3 4))
	(display "tests completed successfully"))