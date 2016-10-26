; Exercise 1.15
; Order of growth of recursive sine approximation

; a) The procedure p is applied 5 times when (sine 12.15) is evaluated

; b) When (sine a) is evaluated, the orders of growth are:
; Space: O(log(a))
; Steps: O(log(a))

; More specifically, the number of times p is called is (and thus the memory/step usage) is:
; ceiling(log3(k*a)), where k = 10 and log3 is logarithm with a base of 3


(define (perf-markup)
	(let ((counter 0))
		(define (increment-counter)
			(set! counter (+ counter 1)))
		(define (reset-counter)
			(set! counter 0))
		(define (get-counter)
			counter)
		(define (dispatch m)
			(cond ((eq? m 'inc) increment-counter)
				  ((eq? m 'reset) reset-counter)
				  ((eq? m 'get) get-counter)))
		dispatch))

(define perf (perf-markup))
(define output-file (open-output-file "Complexity.csv"))

(define (cube x) (* x x x))

(define (p x)
	((perf 'inc))
	(- (* 3 x) (* 4 (cube x))))

(define (sine angle)
	(if (not (> (abs angle) 0.1))
		angle
		(p (sine (/ angle 3.0)))))
		
(define (perf-test n)
	(define (iter i)
		(cond ((< i n)
				(display i output-file)
				(display "," output-file)
				(sine i)
				(display ((perf 'get)) output-file)
				((perf 'reset))
				(newline output-file)
				(iter (+ i 1)))
			  (else (flush-output output-file))))
	(iter 0))