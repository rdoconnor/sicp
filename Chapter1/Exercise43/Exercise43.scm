; Exercise 1.43
; repeated application of f

; f is a one-argument procedure
; n is a positive integer
(define (repeated f n)
	(cond ((<= n 0) (error "n must be positive"))
		  ((= n 1) f)
		  (else (compose f (repeated f (- n 1))))))


; f, g are one argument procedures
(define (compose f g)
	(lambda (x) (f (g x))))
	
; test cases
; ((repeated square 2) 5)
; 625
;
; ((repeated square 1) 5)
; 25