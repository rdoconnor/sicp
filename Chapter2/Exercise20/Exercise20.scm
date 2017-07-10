; Exercise 2.20
; Dotted-tail notation


(define (same-parity . n)
	(define (iter original-list new-list even)
		(cond ((null? original-list)
				(reverse new-list))
			  ((eq? (even? (car original-list)) even)
				(iter (cdr original-list) (cons (car original-list) new-list) even))
			  (else
				(iter (cdr original-list) new-list even))))
	(cond ((null? n) '())
		  (else (iter n '() (even? (car n))))))
		  
(define (unit-tests)
	(assert (equal? (same-parity 1 2 3 4 5 6 7) (list 1 3 5 7)))
	(assert (equal? (same-parity 2 3 4 5 6 7) (list 2 4 6)))
	(assert (equal? (same-parity 0) (list 0)))
	(assert (equal? (same-parity) '()))
	(display "tests completed successfully"))