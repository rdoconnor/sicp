; Exercise 2.5
; An alternative representation for pairs of non-negative integers
; For non-negative integers a,b, we can represent the pair with 2^a * 3^b


(define (cons x y)
	(* (expt 2 x) (expt 3 y)))

(define (car z)
	(define (iter rem count)
		(if (= (remainder rem 2) 0)
			(iter (/ rem 2) (+ count 1))
			count))
	(iter z 0))
	
(define (cdr z)
	(define (iter rem count)
		(if (= (remainder rem 3) 0)
			(iter (/ rem 3) (+ count 1))
			count))
	(iter z 0))
	

; Unit tests
(define (test-cases)
	(define (pair-test-case x y)
		(let ((z (cons x y)))
			(assert (= (car z) x))
			(assert (= (cdr z) y))))
	(pair-test-case 0 0)
	(pair-test-case 0 1)
	(pair-test-case 1 0)
	(pair-test-case 2 3)
	(pair-test-case 13 49)
	(display "Test cases completed"))