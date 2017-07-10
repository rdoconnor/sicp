; Exercise 2.35
; Rewriting count-leaves

; Accumulate procedure provided in section 2.2.1
(define (accumulate op initial sequence)
	(if (null? sequence)
		initial
		(op (car sequence)
			(accumulate op initial (cdr sequence)))))
			
(define (count-leaves t)
	(accumulate + 0 (map (lambda (sub-tree)
								(if (pair? sub-tree)
									(count-leaves sub-tree)
									1))
						t)))
									
									
(define (unit-tests)
	(define (test-answer argument solution)
		(assert (equal? (count-leaves argument) solution)))
	(let ((x (cons (list 1 2) (list 3 4))))
		(test-answer '() 0)
		(test-answer (list 1) 1)
		(test-answer (list 1 2 3) 3)
		(test-answer x 4)
		(test-answer (list x x) 8))
	(display "tests completed successfully"))