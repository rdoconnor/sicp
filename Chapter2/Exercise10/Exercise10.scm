; Exercise 2.10
; Error for dividing by an interval that spans 0

; Constructor and selectors (from 2.7)
(define (make-interval a b) (cons a b))

(define (lower-bound interval)
	(min (car interval) (cdr interval)))

(define (upper-bound interval)
	(max (car interval) (cdr interval)))

; Multiplication of two intervals (from text)
(define (mul-interval x y)
	(let ((p1 (* (lower-bound x) (lower-bound y)))
		  (p2 (* (lower-bound x) (upper-bound y)))
		  (p3 (* (upper-bound x) (lower-bound y)))
		  (p4 (* (upper-bound x) (upper-bound y))))
		(make-interval (min p1 p2 p3 p4)
					   (max p1 p2 p3 p4))))

; based on div-interval in text except with error handling for dividing by an interval that spans 0					   
(define (div-interval x y)
	; error if dividend spans 0
	(cond ((<= (* (lower-bound y) (upper-bound y)) 0)
				(error "Dividend spans 0"))
		  (else (mul-interval x
				  (make-interval (/ 1.0 (upper-bound y))
								 (/ 1.0 (lower-bound y)))))))
