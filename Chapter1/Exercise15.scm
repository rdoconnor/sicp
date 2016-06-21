(define (cube x) (* x x x))

(define (p x)
	(display "P")
	(- (* 3 x) (* 4 (cube x))))

(define (sine angle)
	(if (not (> (abs angle) 0.1))
		angle
		(p (sine (/ angle 3.0)))))
		
; a) The procedure p is applied 5 times when (sine 12.15) is evaluated

; b) When (sine a) is evaluated, the orders of growth are:
; Space: O(log(a))
; Steps: O(log(a))

; More specifically, the number of times (sine) is called is (and thus the memory/step usage) is:
; O(log3(k*a)), where k = 30 and log3 is logarithm with a base of 3