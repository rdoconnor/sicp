; Exercise 2.31
; Generalizing tree map

(define (tree-map proc tree)
	(map (lambda (sub-tree)
				(if (pair? sub-tree)
					(tree-map proc sub-tree)
					(proc sub-tree)))
		tree))
		
(define (square-tree tree) (tree-map square tree))
		
(define (unit-tests)
	(define (test-answer argument solution)
		(assert (equal? (square-tree argument) solution)))
	(test-answer '() '())
	(test-answer (list 2) (list 4))
	(test-answer (list 2 3) (list 4 9))
	(test-answer (list 1 (list 2 (list 3 4) 5) (list 6 7)) (list 1 (list 4 (list 9 16) 25) (list 36 49)))
	(display "tests completed successfully"))