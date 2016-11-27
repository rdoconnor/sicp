; Exercise 1.35
; Finding the golden ratio via a fixed point of the transformation x |-> 1 + 1/x

(define tolerance 0.00001)

(define (fixed-point f first-guess)
	(define (close-enough? v1 v2)
		(< (abs (- v1 v2)) tolerance))
	(define (try guess)
		(let ((next (f guess)))
			(if (close-enough? guess next)
				next
				(try next))))
	(try first-guess))

; (fixed-point (lambda (x) (+ 1 (/ 1 x))) 2.0)
; 1.618032786885248