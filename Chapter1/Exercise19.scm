; Exercise 1.19

(define (fib n)
	(fib-iter 1 0 0 1 n))
	
(define (fib-iter a b p q count)
	(cond ((= count 0) b)
		  ((even? count)
			(fib-iter a
					  b
					  (+ (square p) (square q))
					  (+ (* 2 p q) (square q))
					  (/ count 2)))
		  (else (fib-iter (+ (* b q) (* a q) (* a p))
						  (+ (* b p) (* a q))
						  p
						  q
						  (- count 1)))))
						  
(define (fib-answer n)
	(define (iter a b count)
		(if (= count 0)
			b
			(iter (+ a b) a (- count 1))))
	(iter 1 0 n))
						  
(define (test-cases)
	(let ((limit 1000)
		  (passes 0)
		  (fails 0))
		(define (iter n)
			(cond ((< n limit)
					(cond ((= (fib n) (fib-answer n))
							(set! passes (+ passes 1))
							(iter (+ n 1)))
						  (else
							(set! fails (+ fails 1))
							(display "Failed: ")
							(display n)
							(newline))))))
		(iter 0)
		(display "Passes: ")
		(display passes)
		(newline)
		(display "Fails: ")
		(display fails)
		(newline)))