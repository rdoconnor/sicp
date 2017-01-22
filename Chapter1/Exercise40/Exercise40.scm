; Exercise 1.40
; Approximating zeros of a cubic
; For cubic of form x^3 + ax^2 + bx + c
; Find zeros



(define (newton-transform g)
	(lambda (x)
		(- x (/ (g x) ((deriv g) x)))))

(define dx 0.00001)
		
(define (deriv g)
	(lambda (x)
		(/ (- (g (+ x dx)) (g x))
			dx)))

(define (newtons-method g guess)
	(fixed-point (newton-transform g) guess))

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