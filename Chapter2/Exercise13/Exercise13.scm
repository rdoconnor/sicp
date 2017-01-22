; Exercise 2.13
; Approximating tolerance percentage when multiplying intervals

; Approximation formula:
; p3 = (p1+p2) / (1 + p1*p2)
; where p1,p2 are tolerance percentages of the factor intervals
; and p3 is the tolerance percentage of the product interval

(define (tolerance-of-product x y)
	(let ((p1 (percentage-tolerance x))
		  (p2 (percentage-tolerance y)))
		(/ (+ p1 p2)
		   (+ 1 (* p1 p2)))))

; V3 constructor and selectors (from Exercise 2.12)
; Percentage is out of 1, not 100
(define (make-center-percentage c p)
	(make-center-width c (abs (* c p))))
	
(define (percentage-tolerance i)
	; equivalent to width / center
	(abs (/ (- (upper-bound i) (lower-bound i))
	   (+ (upper-bound i) (lower-bound i)))))

; V2 constructor and selectors (from text)
(define (make-center-width c w)
	(make-interval (- c w) (+ c w)))
	
(define (center i)
	(/ (+ (lower-bound i) (upper-bound i)) 2))
	
(define (width i)
	(abs (/ (- (upper-bound i) (lower-bound i)) 2)))
	
; V1 constructor and selectors (from 2.7)
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
					   
(define (test-cases)
	(define (appx-equal m n)
		(< (abs (- m n)) 0.0001))
	(define (check-product-tolerances x y)
		(let ((percentage-estimate (tolerance-of-product x y))
			  (actual-percentage (percentage-tolerance (mul-interval x y))))
			(assert (appx-equal percentage-estimate actual-percentage))))
	(check-product-tolerances (make-center-percentage 100 0.01) (make-center-percentage 200 0.01))
	(display "test completed"))