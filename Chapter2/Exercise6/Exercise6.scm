; Exercise 2.6
; Church numerals

; Given the definitions for the procedures zero and add-1, define the procedures for:
; one, two, and addition (I call it add)
; These definitions can't be in terms of repeated use of zero and add-1

(define zero (lambda (f) (lambda (x) x)))

(define (add-1 n)
	(lambda (f) (lambda (x) (f ((n f) x)))))

(define one (lambda (f) (lambda (x) (f x))))

(define two (lambda (f) (lambda (x) (f (f x)))))

(define three (lambda (f) (lambda (x) (f (f (f x))))))

(define (add m n)
	(lambda (f) (lambda (x) ((m f) ((n f) x)))))


; func used for testing
(define func (lambda (n) (+ n 1)))

(define (test-cases)
	(assert (= ((zero func) 1) 1))
	(assert (= ((one func) 1) 2))
	(assert (= ((two func) 1) 3))
	(assert (= ((three func) 1) 4))
	(let ((four (add-1 three)))
		(assert (= ((four func) 1) 5)))
	(let ((five (add two three)))
		(assert (= ((five func) 1) 6)))
	(display "tests completed"))