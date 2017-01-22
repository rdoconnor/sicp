; Exercise 1.42
; Composition of two functions:
; x -> f(g(x))

; f, g are one argument procedures
(define (compose f g)
	(lambda (x) (f (g x))))
	
(define (inc x) (+ x 1))

; Test Case:
; ((compose square inc) 6)
; 49