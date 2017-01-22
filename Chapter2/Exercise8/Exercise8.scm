; Exercise 2.8
; subtracting intervals

; Constructor and selectors (from 2.7)
(define (make-interval a b) (cons a b))

(define (lower-bound interval)
	(min (car interval) (cdr interval)))

(define (upper-bound interval)
	(max (car interval) (cdr interval)))

; When subtracting two intervals
; a - b = c
; lower-bound(c) = lower-bound(a) - upper-bound(b)
; upper-bound(c) = upper-bound(a) - lower-bound(b)
(define (sub-interval x y)
	(make-interval (- (lower-bound x) (upper-bound y))
				   (- (upper-bound x) (lower-bound y))))
				   
(define (test-cases)
	(let ((x (make-interval 3 4))
		  (y (make-interval 1 2)))
		(let ((z (sub-interval x y)))
			(assert (= 1 (lower-bound z)))
			(assert (= 3 (upper-bound z)))
			(display "test completed"))))