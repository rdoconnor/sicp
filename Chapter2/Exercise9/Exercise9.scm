; Exercise 2.9
; Evaluating the width of intervals

; Constructor and selectors (from 2.7)
(define (make-interval a b) (cons a b))

(define (lower-bound interval)
	(min (car interval) (cdr interval)))

(define (upper-bound interval)
	(max (car interval) (cdr interval)))

; Width of interval (by definition given in text)
(define (width interval)
	(abs (/ (- (upper-bound interval)
			   (lower-bound interval))
		2)))

; Multiplication of two intervals (from text)
(define (mul-interval x y)
	(let ((p1 (* (lower-bound x) (lower-bound y)))
		  (p2 (* (lower-bound x) (upper-bound y)))
		  (p3 (* (upper-bound x) (lower-bound y)))
		  (p4 (* (upper-bound x) (upper-bound y))))
		(make-interval (min p1 p2 p3 p4)
					   (max p1 p2 p3 p4))))
			
; Show that the width of the sum of two intervals is a function only of the widths of the intervals being added
; 
; Given x + y = z, where x,y,z are intervals and lower-bound and upper-bound return integers
; 1. width(z) = |upper-bound(z) - lower-bound(z) / 2|			(by definition of width)
; 2. upper-bound(z) = upper-bound(x) + upper-bound(y)		(by definition of addition)
; 3. lower-bound(z) = lower-bound(x) + lower-bound(y)		(by definition of addition)
; 4. width(z) = |((upper-bound(x) + upper-bound(y)) - (lower-bound(x) + lower-bound(y))) / 2|				(substitute 2 and 3 into 1)
; 5. width(z) = |((upper-bound(x) - lower-bound(x)) + (upper-bound(y) - lower-bound(y))) / 2|
;	(by commutative and associative laws of addition and subtraction over integers)
; 6. width(z) = |(width(x) + width(y)) / 2|					(by definition of width)
; 
; Therefore, the width of the sum of two integers is a function only of the widths of the intervals being added
;
;
; This is not the case for multiplication. The width of the product is also a function of the magnitude of the
; lower and upper bounds of the intervals being multiplied
; See below for an example of two pairs of intervals being multiplied.
; Note that all the intervals being multiplied have the same width, but the two products have different widths.

(define (mult-test)
	(let ((a (make-interval 1 2))
		  (b (make-interval 3 4))
		  (x (make-interval 101 102))
		  (y (make-interval 103 104)))
		; width is 1/2 for all multiplicands/ multipliers
		(assert (= (width a) (width b) (width x) (width y)))
		(let ((c (mul-interval a b))
			  (z (mul-interval x y)))
			; however the two products have different widths
			(assert (not (= (width c) (width z))))
			(display (width c))
			(newline)
			(display (width z)))))