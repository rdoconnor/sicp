; Exercise 2.32
; Generating the power set of a set

(define (subsets s)
	(if (null? s)
		(list '())
		(let ((rest (subsets (cdr s))))
			(append rest (map 
							(lambda (x) (append (list (car s)) x))
							rest)))))
							
							
(define (unit-tests)
	(define (test-answer argument solution)
		(assert (equal? (subsets argument) solution)))
	(test-answer '() (list '()))
	(test-answer (list 1) (list '() (list 1)))
	(test-answer (list 1 2 3) (list '() (list 3) (list 2) (list 2 3) (list 1) (list 1 3) (list 1 2) (list 1 2 3)))
	(display "tests completed successfully"))