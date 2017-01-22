; Exercise 1.45
; n-th root function with average damping

; find the n-th root of x
(define (nth-root x n)
	(define (get-damp-count)
		(cond ((< n 2) (error "n must be >= 2"))
			  ((<= n 3) 1)
			  ((<= n 7) 2)
			  ((<= n 12) 3)
			  (else 4)))
	(nth-root-helper x n (get-damp-count)))

(define (nth-root-helper x n damp-count)
	(fixed-point ((repeated average-damp damp-count) (lambda (y) (/ x (expt y (- n 1)))))
				 1.0))


; f is a one-argument procedure
; n is a positive integer
(define (repeated f n)
	(cond ((<= n 0) (error "n must be positive"))
		  ((= n 1) f)
		  (else (compose f (repeated f (- n 1))))))


; f, g are one argument procedures
(define (compose f g)
	(lambda (x) (f (g x))))

(define (average-damp f)
	(define (average m n) (/ (+ m n) 2))
	(lambda (x) (average x (f x))))

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