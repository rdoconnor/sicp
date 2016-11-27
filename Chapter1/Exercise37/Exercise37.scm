; Exercise 1.37
; Continued fractions
;
;
; Based on my procedure answer-checker,
; cont-frac approximates 1 / phi (where phi is the golden ratio), based on the call
; (cont-frac (lambda (i) 1.0) (lambda (i) 1.0) k) and approximates it to the nearest four decimal places
; (so to 1.6180) when k is >= 12
	
; Note that i varies from 1 to k and not 0 to k-1
; (that's needed for properly defining procedures n and d)
(define (cont-frac-recursive n d k)
	(define (recursive i)
		(cond ((> i k) 0)
			(else
				(/ (n i) 
				   (+ (d i)
					  (recursive (+ i 1)))))))
	(recursive 1))

(define (cont-frac-iter n d k)
	(define (iter i total)
		(cond ((< i 1)
				total)
			  (else
				(iter (- i 1) (/ (n i) (+ (d i) total))))))
	(iter k 0))
	
(define cont-frac cont-frac-iter)

(define (answer-checker)
	(define threshold 0.00001)
	(define answer 0.61803)
	(define (always-one i) 1.0)
	(define (close-enough? answer guess)
		(< (abs (- answer guess)) threshold))
	(define (iter i)
		(let ((possible-answer (cont-frac always-one always-one i)))
			(cond ((> i 100)
					(display "Surpassed i = 100")
					(newline)
					(display possible-answer)
					(newline)
					(display ((abs (- answer possible-answer)))))
				  ((close-enough? answer possible-answer)
					(display "Answer: ")
					(display answer)
					(newline)
					(display "i = ")
					(display i))
				  (else
					(iter (+ i 1))))))
	(iter 1))
				