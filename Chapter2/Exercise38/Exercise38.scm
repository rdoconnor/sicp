; Exercise 2.38
; Comparing fold-left and fold-right

; Accumulate procedure provided in section 2.2.1
(define (accumulate op initial sequence)
	(if (null? sequence)
		initial
		(op (car sequence)
			(accumulate op initial (cdr sequence)))))
			
(define fold-right accumulate)

(define (fold-left op initial sequence)
	(define (iter result rest)
		(if (null? rest)
			result
			(iter (op result (car rest))
				(cdr rest))))
	(iter initial sequence))
	
; (fold-right / 1 (list 1 2 3))
; answer:
; 3/2

; (fold-left / 1 (list 1 2 3))
; answer:
; 1/6

; (fold-right list '() (list 1 2 3))
; answer:
; (1 (2 (3 ())))

; (fold-left list '() (list 1 2 3))
; answer:
; (((() 1) 2) 3)

; fold-left and fold-right will give the same answer for any sequence if the operator is associative
; i.e. if (equal? (op a b) (op b a))
; for example, addition:

(define (unit-tests)
	(define (test-answer op initial seq)
		(assert (equal? (fold-left op initial seq) (fold-right op initial seq))))
	(test-answer + 1 (list 1 2 3))
	(display "tests completed successfully"))