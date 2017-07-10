; Exercise 2.21
; Creating square-list procedures

(define (square-list1 items)
	(if (null? items)
		'()
		(cons (square (car items)) (square-list1 (cdr items)))))
		
(define (square-list2 items)
	(map square items))
		
(define (unit-tests)
	(define (test-answer argument solution)
		(assert (equal? (square-list1 argument) solution))
		(assert (equal? (square-list2 argument) solution)))
	(test-answer (list 1 2 3 4) (list 1 4 9 16))
	(test-answer (list 0) (list 0))
	(test-answer (list -1 -2 -3 -4) (list 1 4 9 16))
	(test-answer '() '())
	(display "tests completed successfully"))