; Exercise 2.33
; Redefining basic list-manipulation procedures using modular sequence-based procedures

; Accumulate procedure provided in section 2.2.1
(define (accumulate op initial sequence)
	(if (null? sequence)
		initial
		(op (car sequence)
			(accumulate op initial (cdr sequence)))))

(define (map p sequence)
	(accumulate (lambda (x y) (cons (p x) y)) '() sequence))
	
(define (append seq1 seq2)
	(accumulate cons seq2 seq1))
	
(define (length sequence)
	(accumulate (lambda (x y) (+ 1 y)) 0 sequence))
	
	
(define (map-unit-tests)
	(define (test-answer op argument solution)
		(assert (equal? (map op argument) solution)))
	(test-answer abs (list -10 2.5 -11.6 17) (list 10 2.5 11.6 17))
	(test-answer square (list 1 2 3 4) (list 1 4 9 16))
	(test-answer * '() '())
	(display "map tests completed successfully")
	(newline))
	
(define (append-unit-tests)
	(define (test-answer arg1 arg2 solution)
		(assert (equal? (append arg1 arg2) solution)))
	(test-answer (list 1) (list 2) (list 1 2))
	(test-answer (list 1 2) (list 3 4 5) (list 1 2 3 4 5))
	(test-answer '() '() '())
	(display "append tests completed successfully")
	(newline))
	
(define (length-unit-tests)
	(define (test-answer argument solution)
		(assert (equal? (length argument) solution)))
	(test-answer (list 1) 1)
	(test-answer (list 1 2 3 4 5) 5)
	(test-answer '() 0)
	(display "length tests completed successfully")
	(newline))
	
(define (unit-tests)
	(map-unit-tests)
	(append-unit-tests)
	(length-unit-tests))