; Exercise 1.44
; Smoothing of functions

(define dx 0.00001)

(define (smooth f)
	(define (average a b c)
		(/ (+ a b c) 3))
	(lambda (x)
		(average
			(f (- x dx))
			(f x)
			(f (+ x dx)))))

; f is a one-argument procedure
; n is a positive integer
(define (n-fold-smooth f n)
	(repeated (smooth f) n))
	
	
; f is a one-argument procedure
; n is a positive integer
(define (repeated f n)
	(cond ((<= n 0) (error "n must be positive"))
		  ((= n 1) f)
		  (else (compose f (repeated f (- n 1))))))

; f, g are one argument procedures
(define (compose f g)
	(lambda (x) (f (g x))))