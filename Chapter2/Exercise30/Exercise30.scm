; Exercise 2.30
; Squaring each element of a tree

; Square-tree defined directly
(define (square-tree1 tree)
	(cond ((null? tree) '())
		  ((not (pair? tree)) (square tree))
		  (else
			(cons (square-tree1 (car tree))
				  (square-tree1 (cdr tree))))))
				  
(define (square-tree2 tree)
	(map (lambda (sub-tree)
			(if (pair? sub-tree)
				(square-tree2 sub-tree)
				(square sub-tree)))
		tree))
				  
(define (unit-tests)
	(define (test-answer argument solution)
		(assert (equal? (square-tree1 argument) solution))
		(assert (equal? (square-tree2 argument) solution)))
	(test-answer '() '())
	(test-answer (list 2) (list 4))
	(test-answer (list 2 3) (list 4 9))
	(test-answer (list 1 (list 2 (list 3 4) 5) (list 6 7)) (list 1 (list 4 (list 9 16) 25) (list 36 49)))
	(display "tests completed successfully"))