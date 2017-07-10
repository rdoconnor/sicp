; Exercise 2.27
; Deep reverse of tree structures


; reverse (from exercise 2.18)
(define (reverse items)
	(define (iter original-list new-list)
		(if (null? original-list)
			new-list
			(iter (cdr original-list) (cons (car original-list) new-list))))
	(iter items '()))
	
(define (deep-reverse items)
	(cond ((null? items) '())
		  ((not (pair? items)) items)
		  ((null? (cdr items)) (deep-reverse (car items)))
		  (else
			(list (deep-reverse (cdr items))
				  (deep-reverse (car items))))))
				  
(define (unit-tests)
	(define (test-answer argument solution)
		(assert (equal? (deep-reverse argument) solution)))
	(test-answer (list (list 1 2) (list 3 4)) (list (list 4 3) (list 2 1)))
	(test-answer (list 1 2) (list 2 1))
	(test-answer (list (list 1 2)) (list 2 1))
	(test-answer '() '())
	(display "tests completed successfully"))