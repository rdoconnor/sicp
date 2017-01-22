; Exercise 2.11
; Creating a more efficient multiplication

; Constructor and selectors (from 2.7)
(define (make-interval a b) (cons a b))

(define (lower-bound interval)
	(min (car interval) (cdr interval)))

(define (upper-bound interval)
	(max (car interval) (cdr interval)))
	

(define (mul-interval x y)
	(let ((xL (lower-bound x))
		  (xU (upper-bound x))
		  (yL (lower-bound y))
		  (yU (upper-bound y)))
		(cond ((and (< xL 0) (< xU 0) (< yL 0) (< yU 0))
				(make-interval (* xU yU) (* xL yL)))
			  ((and (< xL 0) (< xU 0) (< yL 0) (>= yU 0))
			    (make-interval (* xL yU) (* xL yL)))
			  ((and (< xL 0) (< xU 0) (>= yL 0) (>= yU 0))
				(make-interval (* xL yU) (* xU yL)))
			  ((and (< xL 0) (>= xU 0) (< yL 0) (< yU 0))
				(make-interval (* xU yL) (* xL yL)))
			  ((and (< xL 0) (>= xU 0) (< yL 0) (>= yU 0))
				(make-interval (min (* xL yU) (* xU yL))
							   (max (* xL yL) (* xU yU))))
			  ((and (< xL 0) (>= xU 0) (>= yL 0) (>= yU 0))
				(make-interval (* xL yU) (* xU yU)))
			  ((and (>= xL 0) (>= xU 0) (< yL 0) (< yU 0))
				(make-interval (* xU yL) (* xL yU)))
			  ((and (>= xL 0) (>= xU 0) (< yL 0) (>= yU 0))
				(make-interval (* xU yL) (* xU yU)))
			  ((and (>= xL 0) (>= xU 0) (>= yL 0) (>= yU 0))
				(make-interval (* xL yL) (* xU yU)))
			  (else
				; we should never hit this
				(error "Multiplying unhandled signs")))))
	
	
; Multiplication of two intervals (from text)
; This will be used for comparison
(define (slow-mul-interval x y)
	(let ((p1 (* (lower-bound x) (lower-bound y)))
		  (p2 (* (lower-bound x) (upper-bound y)))
		  (p3 (* (upper-bound x) (lower-bound y)))
		  (p4 (* (upper-bound x) (upper-bound y))))
		(make-interval (min p1 p2 p3 p4)
					   (max p1 p2 p3 p4))))
					   
	
; unit tests	
(define (test-cases)
	(define (compare-products x y)
		(let ((oldZ (slow-mul-interval x y))
			  (newZ (mul-interval x y)))
			(assert (= (lower-bound oldZ) (lower-bound newZ)))
			(assert (= (upper-bound oldZ) (upper-bound newZ)))))
	; Case 1: (-,-) * (-,-)
	(compare-products (make-interval -4 -1) (make-interval -11 -5))
	
	; Case 2: (-,-) * (-,+)
	(compare-products (make-interval -11 -5) (make-interval -7 4))
	(compare-products (make-interval -11 -5) (make-interval -6 0))
	
	; Case 3: (-,-) * (+,+)
	(compare-products (make-interval -11 -5) (make-interval 4 7))
	(compare-products (make-interval -11 -5) (make-interval 0 4))
	
	; Case 4: (-,+) * (-,-)
	(compare-products (make-interval -11 5) (make-interval -7 -4))
	(compare-products (make-interval -11 0) (make-interval -7 -4))
	
	; Case 5: (-,+) * (-,+)
	(compare-products (make-interval -11 5) (make-interval -7 4))
	(compare-products (make-interval -11 0) (make-interval -7 4))
	(compare-products (make-interval -11 8) (make-interval -7 0))
	(compare-products (make-interval -11 0) (make-interval -7 0))
	
	; Case 6: (-,+) * (+,+)
	(compare-products (make-interval -11 5) (make-interval 3 7))
	(compare-products (make-interval -11 0) (make-interval 2 8))
	(compare-products (make-interval -11 5) (make-interval 0 4))
	(compare-products (make-interval -11 0) (make-interval 0 4))
	
	; Case 7: (+,+) * (-,-)
	(compare-products (make-interval 5 11) (make-interval -7 -4))
	(compare-products (make-interval 0 5) (make-interval -7 -3))
	
	; Case 8: (+,+) * (-,+)
	(compare-products (make-interval 5 11) (make-interval -7 4))
	(compare-products (make-interval 0 5) (make-interval -7 4))
	(compare-products (make-interval 5 11) (make-interval -7 0))
	(compare-products (make-interval 0 6) (make-interval -7 0))
	
	; Case 9: (+,+) * (+,+)
	(compare-products (make-interval 5 11) (make-interval 4 7))
	(compare-products (make-interval 0 5) (make-interval 4 13))
	(compare-products (make-interval 0 2) (make-interval 0 4))
	(compare-products (make-interval 0 5) (make-interval 0 12))
	(compare-products (make-interval 0 0) (make-interval 0 0))
	
	(display "test passes completed"))