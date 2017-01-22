; Exercise 1.41
; double procedure

; f is a procedure of one argument
(define (double f)
	(lambda (x) (f (f x))))

(define (inc x) (+ x 1))

(define inc2 (double inc))

; (((double (double double)) inc) 5)
; return 21