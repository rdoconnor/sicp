; Exercise 2.12
; Creating a new constructor based on a center and a percentage

; V3 constructor and selectors (based on center and percentage)
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


(define (test-cases)
	(define (test-center-percentage c p)
		(let ((z (make-center-percentage c p)))
			(assert (= (center z) c))
			(assert (= (percentage-tolerance z) p))))
	(test-center-percentage 100 0.1)
	(test-center-percentage -100 0.2)
	(display "tests completed"))