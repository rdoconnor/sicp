; Exercise 2.54
; Defining the procedure equal?

(define (new-equal? a b)
	(cond ((and (null? a) (null? b)) #t)
		  ((and (null? a) (not (null? b))) #f)
		  ((and (not (null? a)) (null? b)) #f)
		  ((and (pair? a) (pair? b))
			(and (new-equal? (car a) (car b)) (new-equal? (cdr a) (cdr b))))
		  ((and (not (pair? a)) (not (pair? b))) (eqv? a b))
		  (else #f)))
		  
		  
(define (unit-tests)
	(define (test a b)
		; I want my new-equal? procedure to always return the same result as the equal?
		; procedure defined in the mit-scheme implementation
		(assert (eq? (new-equal? a b) (equal? a b))))
	(test '() '())
	(test 1 '())
	(test '() 1)
	(test 1 1)
	(test 1 (list 1))
	(test (list 1) 1)
	(test 1 '1)
	(test (list 1) '(1))
	(test (list 1 2) (list 1 3))
	(test 'test 'test)
	(test '() (list))
	(test (list 1 2 3) (list 1 (list 2) 3))
	(test (list 1 2) (list (list 1 2)))
	(test '(this is a list) '(this is a list))
	(test '(this is a list) '(this (is a) list))
	(display "unit tests completed successfully"))