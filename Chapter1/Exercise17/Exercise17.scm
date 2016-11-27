; Exercise 1.17
; Log(n) multiplication with recursive process

(define (new-mult a b)
	(cond ((= b 0) 0)
		  ((even? b) (double (new-mult a (halve b))))
		  (else (+ a (new-mult a (- b 1))))))
		  
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