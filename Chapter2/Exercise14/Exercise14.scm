; Exercise 2.14
; Exploring different answers from algebraically equivalent expressions

; RESULTS FROM INVESTIGATION:
; There is an issue in interval arithmetic in which repeated use of the same term in an equation
; will cause us to have an overestimation of width in the final answer.
; For example, for some interval A, A / A does not equal a multiplicative identity element.
; A / A equals an element centered on 1 but whose width prevents it from being useful as an identity element
; because A * (A / A) != A. When A is used repeatedly in an equation, the width grows with each operation.
; So (A / A) ^ n * A for arbitrarily large n will produce an interval that has the same center as A but
; has a width that grows arbitrarily large with n.
; The same issue arises with interval addition and subtraction.
; For the most accurate calculations, we should minimize or eliminate all repeated uses of the same terms.

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

; Addition of intervals (from text)
(define (add-interval x y)
	(make-interval (+ (lower-bound x) (lower-bound y))
				   (+ (upper-bound x) (upper-bound y))))

; Subtraction of intervals (from 2.8)
(define (sub-interval x y)
	(make-interval (- (lower-bound x) (upper-bound y))
				   (- (upper-bound x) (lower-bound y))))

; Multiplication of two intervals (from text)
(define (mul-interval x y)
	(let ((p1 (* (lower-bound x) (lower-bound y)))
		  (p2 (* (lower-bound x) (upper-bound y)))
		  (p3 (* (upper-bound x) (lower-bound y)))
		  (p4 (* (upper-bound x) (upper-bound y))))
		(make-interval (min p1 p2 p3 p4)
					   (max p1 p2 p3 p4))))

; Improved division of intervals (from 2.10)					   
(define (div-interval x y)
	; error if dividend spans 0
	(cond ((<= (* (lower-bound y) (upper-bound y)) 0)
				(error "Dividend spans 0"))
		  (else (mul-interval x
				  (make-interval (/ 1.0 (upper-bound y))
								 (/ 1.0 (lower-bound y)))))))
								 
; Resistance formulae (from text)
(define (par1 r1 r2)
	(div-interval (mul-interval r1 r2)
				  (add-interval r1 r2)))
				  
(define (par2 r1 r2)
	(let ((one (make-interval 1 1)))
		(div-interval one
					  (add-interval (div-interval one r1)
									(div-interval one r2)))))
									
; test intervals
(define i1 (make-center-percentage 250 0.01))
(define i2 (make-center-percentage 500 0.002))

(define a1 (div-interval i1 i1))
(define a2 (div-interval i2 i1))

(define r1 (par1 i1 i2))
(define r2 (par2 i1 i2))

(define pt percentage-tolerance)