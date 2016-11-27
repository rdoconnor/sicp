; Exercise 1.39
; Using continued fractions to estimate tan(x)

(define (cont-frac n d k)
	(define (iter i total)
		(cond ((< i 1)
				total)
			  (else
				(iter (- i 1) (/ (n i) (+ (d i) total))))))
	(iter k 0))

(define (tan-cf x k)
	(define (n i)
		(if (= i 1)
			x
			(- (square x))))
	(define (d i)
		(- (* 2 i) 1))
	(cont-frac n d k))