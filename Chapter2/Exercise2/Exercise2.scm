; Exercise 2.2
; Representing points and line segments

; Point constructor
(define (make-point x y)
	(cons x y))
	
; Point selectors
(define (x-point p)
	(car p))
	
(define (y-point p)
	(cdr p))
	
; Line segment constructor
(define (make-segment start-point end-point)
	(cons start-point end-point))
	
; Line segment selectors
(define (start-segment s)
	(car s))
	
(define (end-segment s)
	(cdr s))
	
; Find midpoint of segment
(define (midpoint-segment s)
	(define (average a b) (/ (+ a b) 2))
	(let ((start-point (start-segment s))
		  (end-point (end-segment s)))
		(make-point (average (x-point start-point) (x-point end-point))
					(average (y-point start-point) (y-point end-point)))))
					
(define (print-point p)
	(newline)
	(display "(")
	(display (x-point p))
	(display ",")
	(display (y-point p))
	(display ")"))
	
	
(define (test-cases)
	(let ((p1 (make-point 1 2))
		  (p2 (make-point 11 12)))
		(let ((s (make-segment p1 p2)))
			(print-point (midpoint-segment s)))))