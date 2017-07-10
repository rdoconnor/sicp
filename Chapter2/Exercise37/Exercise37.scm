; Exercise 2.37
; Vector and matrix math

; Accumulate procedure provided in section 2.2.1
(define (accumulate op initial sequence)
	(if (null? sequence)
		initial
		(op (car sequence)
			(accumulate op initial (cdr sequence)))))
			
; accumulate-n from Exercise 2.36
(define (accumulate-n op init seqs)
	(if (null? (car seqs))
		'()
		(cons (accumulate op init (map car seqs))
			  (accumulate-n op init (map cdr seqs)))))
	
; Dot product is given	
(define (dot-product v w)
	(accumulate + 0 (map * v w)))
	
(define (matrix-*-vector m v)
	(map (lambda (x) (dot-product x v)) m))
	
(define (transpose mat)
	(accumulate-n cons '() mat))

(define (matrix-*-matrix m n)
	(let ((cols (transpose n)))
		(map (lambda (r) (matrix-*-vector cols r)) m)))
	
(define (unit-tests)
	(matrix-vector-unit-tests)
	(transpose-unit-tests)
	(matrix-matrix-unit-tests))
	
(define (matrix-vector-unit-tests)
	(define (test-answer mat vec solution)
		(assert (equal? (matrix-*-vector mat vec) solution)))
	(test-answer (list (list 1 1) (list 1 1)) (list 1 1) (list 2 2))
	(test-answer (list (list 1 2) (list 3 4)) (list 5 6) (list 17 39))
	(test-answer (list (list 1 2 3 4) (list 4 5 5 6) (list 6 7 8 9)) (list 1 2 3 4) (list 30 53 80))
	(display "matrix vector tests completed successfully")
	(newline))
	
(define (transpose-unit-tests)
	(define (test-answer mat solution)
		(assert (equal? (transpose mat) solution)))
	(test-answer (list (list 1 2) (list 3 4)) (list (list 1 3) (list 2 4)))
	(test-answer (list (list 1 2 3 4) (list 4 5 5 6) (list 6 7 8 9)) (list (list 1 4 6) (list 2 5 7) (list 3 5 8) (list 4 6 9)))
	(display "transpose tests completed successfully")
	(newline))
	
(define (matrix-matrix-unit-tests)
	(define (test-answer mat1 mat2 solution)
		(assert (equal? (matrix-*-matrix mat1 mat2) solution)))
	(test-answer (list (list 1 2) (list 3 4)) (list (list 5 6) (list 7 8)) (list (list 19 22) (list 43 50)))
	(display "matrix-matrix tests completed successfully")
	(newline))	
