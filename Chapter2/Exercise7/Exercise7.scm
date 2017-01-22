; Exercise 2.7
; Constructors and selectors for the interval data type

; Constructor (provided)
(define (make-interval a b) (cons a b))

; Selectors
; Note that I'm making them more robust to negligent users of the interface who may switch lower/ upper bounds
; instead of simply defining them as car for lower-bound and cdr for upper-bound
(define (lower-bound interval)
	(min (car interval) (cdr interval)))

(define (upper-bound interval)
	(max (car interval) (cdr interval)))


; Test
(define (test-cases)
	(define (interval-test-case x y)
		(let ((z (make-interval x y)))
			(assert (= (lower-bound z) (min x y)))
			(assert (= (upper-bound z) (max x y)))))
		(interval-test-case -1 1)
		(interval-test-case 0 2)
		(interval-test-case 3 1)	; intentionally "bad" case
		(display "test completed"))