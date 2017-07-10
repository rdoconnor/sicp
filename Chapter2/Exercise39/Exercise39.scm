; Exercise 2.39
; Creating reverse based on fold-left and fold-right

; Accumulate procedure provided in section 2.2.1
(define (accumulate op initial sequence)
	(if (null? sequence)
		initial
		(op (car sequence)
			(accumulate op initial (cdr sequence)))))
			
(define fold-right accumulate)

; Fold-left from Exercise 2.38
(define (fold-left op initial sequence)
	(define (iter result rest)
		(if (null? rest)
			result
			(iter (op result (car rest))
				(cdr rest))))
	(iter initial sequence))

(define (reverse-fold-right sequence)
	(fold-right (lambda (x y) (append y (list x))) '() sequence))
	
(define (reverse-fold-left sequence)
	(fold-left (lambda (x y) (cons y x)) '() sequence))
	
(define (unit-tests)
	(define (test-answer seq)
		(assert (equal? (reverse-fold-right seq) (reverse seq)))
		(assert (equal? (reverse-fold-left seq) (reverse seq))))
	(test-answer '())
	(test-answer (list 1))
	(test-answer (list 1 2 3 4))
	(display "tests completed successfully"))