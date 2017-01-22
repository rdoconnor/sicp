; Exercise 1.46
; generalizing iterative improvement

(define (iterative-improve good-enough-proc improve-guess-proc)
	(define (iter x)
		(let ((next (improve-guess-proc x)))
			(cond ((good-enough-proc x next) next)
				  (else (iter next)))))
	iter)

; based on sqrt from section 1.1.7
(define (sqrt-1 x)
	(define (good-enough? prev-guess guess)
		(< (abs (- (square guess) x)) 0.001))
	(define (improve guess)
		(average guess (/ x guess)))
	(define (average a b) (/ (+ a b) 2.0))
	((iterative-improve good-enough? improve) x))
	
; based on fixed-point procedure
(define tolerance 0.00001)

(define (fixed-point f first-guess)
	(define (close-enough? v1 v2)
		(< (abs (- v1 v2)) tolerance))
	((iterative-improve close-enough? f) first-guess))