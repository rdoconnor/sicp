; Exercise 1.11

; Write procedure for:
; f(n) = n if n < 3
; f(n) = f(n-1) + 2*f(n-2) + 3*f(n-3) if n >= 3

; Recursive process
(define (recursive-f n)
	(if (< n 3)
		n
		(+ (recursive-f (- n 1))
		   (* 2 (recursive-f (- n 2)))
		   (* 3 (recursive-f (- n 3))))))
		   
; Iterative process
(define (iterative-f n)
	(define (f-iter i f1 f2 f3)
		(let ((f (+ f1 (* 2 f2) (* 3 f3))))
			(if (= n i)
				f
				(f-iter (+ i 1) f f1 f2))))
	(if (< n 3)
		n
		(f-iter 3 2 1 0)))

; Test to ensure both give equivalent answers
(define (test-differences k)
	(define (test-iter i)
		(cond ((< i k)
				(if (not (= (recursive-f i) (iterative-f i)))
					(error "Functions not equal for n = " i))
				(test-iter (+ i 1)))))
	(test-iter 1))