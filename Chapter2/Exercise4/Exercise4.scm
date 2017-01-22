; Exercise 2.4
; An alternative procedural representation of pairs

; Define cdr based on a given cons and car

(define (cons x y)
	(lambda (m) (m x y)))
	
(define (car z)
	(z (lambda (p q) p)))
	
(define (cdr z)
	(z (lambda (p q) q)))

	
(define (tests)
	(let ((z (cons 1 2)))
		(assert (= (car z) 1))
		(assert (= (cdr z) 2)))
	(display "tests completed"))