; Exercise 2.3
; Representing rectangles in a plane

;----------------------------------------------------------------------------------------------------------
; Implementation 1 of rectangle constructor and selectors	
(define (make-rectangle1 p1 p2)
	(cons p1 p2))

(define (bottom-left-point1 rect)
	(car rect))
	
(define (top-right-point1 rect)
	(cdr rect))

(define (bottom-segment1 rect)
	(let ((x (x-point (top-right-point rect)))
		  (y (y-point (bottom-left-point rect))))
		(make-segment (bottom-left-point rect)
					  (make-point x y))))
					  
(define (right-side-segment1 rect)
	(let ((x (x-point (top-right-point rect)))
		  (y (y-point (bottom-left-point rect))))
		(make-segment (make-point x y)
					  (top-right-point rect))))

;----------------------------------------------------------------------------------------------------------
; Implementation 2 of rectangle constructor and selectors
(define (make-rectangle2 p1 p2)
	(let ((bottom-right-point (make-point (x-point p2) (y-point p1))))
		(cons (make-segment p1 bottom-right-point)
			  (make-segment bottom-right-point p2))))
			  
(define (bottom-left-point2 rect)
	(start-segment (car rect)))

(define (top-right-point2 rect)
	(end-segment (cdr rect)))
	
(define (bottom-segment2 rect)
	(car rect))
	
(define (right-side-segment2 rect)
	(cdr rect))
					 
;----------------------------------------------------------------------------------------------------------					 
; Rectangle constructor using bottom-left and top-right corner points of rectangle
(define make-rectangle make-rectangle2)
	
; Point selectors
(define bottom-left-point bottom-left-point2)
(define top-right-point top-right-point2)
(define bottom-segment bottom-segment2)
(define right-side-segment right-side-segment2)
					  
					  
;----------------------------------------------------------------------------------------------------------
; Area/ Perimeter procedures
					  
(define (rect-area rect)
	(* (segment-length (bottom-segment rect))
	   (segment-length (right-side-segment rect))))

(define (rect-perimeter rect)
	(+ (* 2 (segment-length (bottom-segment rect)))
	   (* 2 (segment-length (right-side-segment rect)))))
					  
;----------------------------------------------------------------------------------------------------------
; Point constructor
(define (make-point x y)
	(cons x y))
	
; Point selectors
(define (x-point p)
	(car p))
	
(define (y-point p)
	(cdr p))
	
(define (distance-between-points p1 p2)
	(sqrt (+ (square (- (x-point p1) (x-point p2)))
			 (square (- (y-point p1) (y-point p2))))))
	
;----------------------------------------------------------------------------------------------------------
; Line segment constructor
(define (make-segment start-point end-point)
	(cons start-point end-point))
	
; Line segment selectors
(define (start-segment s)
	(car s))
	
(define (end-segment s)
	(cdr s))
	
(define (segment-length s)
	(distance-between-points (start-segment s) (end-segment s)))

	
;----------------------------------------------------------------------------------------------------------
; tests

(define p1 (make-point 0 0))
(define p2 (make-point 3 4))
(define r (make-rectangle p1 p2))