; Exercise 1.18

; Loop invariant: a*b + k
; if b = 0 then answer = k
; if b is even then a*b + k = (2a) * (b/2) + k
; else (if b is odd) then a*b + k = a * (b-1) + (k + a)

(define (new-mult a b)
	(define (iter a1 b1 k)
		(cond ((= b1 0) k)
			  ((even? b1) (iter (double a1) (halve b1) k))
			  (else (iter a1 (- b1 1) (+ a1 k)))))
	(iter a b 0))
			  
(define (even? n)
	(= (remainder n 2) 0))
	
(define (double n)
	(* n 2))
	
(define (halve n)
	(/ n 2))

(define test-case-limit 100)
	
(define (test-cases)
	(let ((passes 0)
		 (fails 0))
		(define (a-iter a)
			(define (b-iter b)
				(let ((answer (* a b))
					  (guess (new-mult a b)))
					(if (= answer guess)
						(set! passes (+ passes 1))
						(set! fails (+ fails 1)))
					(if (< b test-case-limit)
						(b-iter (+ b 1)))))
			(b-iter 0)
			(if (< a test-case-limit)
				(a-iter (+ a 1))))
		(a-iter 0)
		(display "Passes: ")
		(display passes)
		(newline)
		(display "Fails: ")
		(display fails)
		(newline)))